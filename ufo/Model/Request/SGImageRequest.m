//
//  SGImageRequest.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageRequest.h"

@implementation SGImageRequest

#pragma mark Properties

@synthesize imageRequestFinished = _imageRequestFinished;

- (id)initWithImageUrl:(NSString *)imageUrl
{
	self = [super initWithURL:[NSURL URLWithString:imageUrl] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30];
	if (self)
	{
		self.HTTPShouldHandleCookies = NO;
		self.HTTPShouldUsePipelining = YES;
		
		_imageRequestFinished = nil;
	}
	return self;
}

#pragma mark Overridden methods (Operation)

- (BOOL)hasCachedResponse
{
	return NO;
}

- (void)requestFinishedWithResponse:(NSURLResponse *)response data:(NSData *)data
{
	@autoreleasepool
	{
		NSHTTPURLResponse * httpResponse = nil;
		if ([response isKindOfClass:NSHTTPURLResponse.class])
		{
			httpResponse = (NSHTTPURLResponse *)response;
		}
		
		if (httpResponse.statusCode == 200 && data.length > 0)
		{
			UIImage * image = [UIImage.alloc initWithData:data];
			
			if (_imageRequestFinished)
			{
				_imageRequestFinished(self, image);
			}
		}
		else
		{
			NSDictionary * userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Invalid HTTP response status code %d", httpResponse.statusCode] forKey:NSLocalizedDescriptionKey];
			NSError * error = [NSError.alloc initWithDomain:@"HTTPStatusCode" code:httpResponse.statusCode userInfo:userInfo];
			[self requestFailedWithResponse:response error:error];
		}
	}
}


@end
