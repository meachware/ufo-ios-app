//
//  SGArticleRequest.m
//  ufo
//
//  Created by SandGro on 21-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleRequest.h"
#import "SGNewsArticle.h"
#import "SGDataManager.h"
#import "NSDictionary+Json.h"

NSString * kSGNewsArticlesChanged = @"kSGNewsArticlesChanged";

@interface SGArticleRequest ()
- (id)initWithHost:(NSString *)host path:(NSString *)path;
- (void)handleResponeWithJson:(id)jsonRoot error:(NSError **)error;

+ (SGJsonRequestFinished)newsArticleProcessor;
+ (SGRequestFailed)contentFailedProcessor;
@end

#pragma mark -

@implementation SGArticleRequest

#pragma mark Properties

@synthesize jsonRequestFinished = _jsonRequestFinished;

#pragma mark Initialization

- (id)initWithHost:(NSString *)host path:(NSString *)path
{
	NSString * url = [NSString stringWithFormat:@"http://%@/%@/", host, path];
	
	self = [super initWithURL:[NSURL.alloc initWithString:url]
				  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
			  timeoutInterval:25.0];
	if (self)
	{
		self.HTTPShouldHandleCookies = NO;
	}
	return self;
}

#pragma mark Public Methods

- (SGArticleRequest *)initNewsArticles
{
	self = [self initWithHost:SGArticleRequest.sgHostName path:@"latest_news_articles"];
	if (self)
	{
		self.jsonRequestFinished = SGArticleRequest.newsArticleProcessor;
		self.requestFailed = SGArticleRequest.contentFailedProcessor;
	}
	return self;
}

#pragma mark Override

- (void)requestFinishedWithResponse:(NSURLResponse *)response data:(NSData *)data
{
	NSHTTPURLResponse * httpResponse = nil;
	if ([response isKindOfClass:NSHTTPURLResponse.class])
	{
		httpResponse = (NSHTTPURLResponse *)response;
	}
	
	if (httpResponse.statusCode == 200 && data.length > 0)
	{
		NSError * error;
		id jsonRoot = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
		
		[self handleResponeWithJson:jsonRoot error:&error];
	}
}

#pragma mark Private Methods

- (void)handleResponeWithJson:(id)jsonRoot error:(NSError **)error
{
	if (*error)
	{
		NSLog(@"Error %@", [*error localizedDescription]);
	}
	else
	{
		if (_jsonRequestFinished)
		{
			if (!_jsonRequestFinished(self, jsonRoot))
			{
				NSLog(@"JSON structure could not be processed");
			}
		}
	}
}

#pragma mark Private class methods

+ (SGJsonRequestFinished)newsArticleProcessor
{
	return ^(SGArticleRequest * request, id json) {
		
		NSManagedObjectContext * context = [SGDataManager.shared managedObjectContext];
		
		for (NSDictionary * dic in json)
		{
			SGNewsArticle * article = [NSEntityDescription insertNewObjectForEntityForName:@"SGBaseArticle" inManagedObjectContext:context];
			article.identifier = [NSNumber numberWithInt:[dic integerForTestedKey:@"id"]];
			article.title = [dic stringForKey:@"title"];
			article.text = [dic stringForKey:@"text"];
			article.publishDate = [dic dateForTestedKey:@"publish_date"];
			
			NSError * error;
			if (![context save:&error])
			{
				NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
			}
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[NSNotificationCenter.defaultCenter postNotificationName:kSGNewsArticlesChanged object:self];
		});
		
		return YES;
	};
}

+ (SGRequestFailed)contentFailedProcessor
{
	return ^(SGAbstractRequest * request, NSHTTPURLResponse * httpResponse, NSError * error) {
		
		NSLog(@"Request %@ failed. (%@ %d: %@)", request.URL, error.domain, error.code, error.localizedDescription);
		
	};
}

@end
