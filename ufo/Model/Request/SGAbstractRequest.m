//
//  SGAbstractRequest.m
//  ufo
//
//  Created by SandGro on 17-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGAbstractRequest.h"
#import "SGRequestManager.h"

@implementation SGAbstractRequest

#pragma mark Properties

@synthesize requestNotInCache = _requestNotInCache;
@synthesize requestFinished = _requestFinished;
@synthesize requestFailed = _requestFailed;

#pragma mark Class methods

+ (NSString *)sgHostName
{
	return @"ufo-app.appspot.com";
}

+ (NSString *)sgStaticImageHostName
{
	return @"ufo-app.appspot.com";
}

#pragma mark Operation methods

- (BOOL)hasCachedResponse
{
	return NO;
}

- (void)requestNotFoundInCache
{
	if (_requestNotInCache)
	{
		_requestNotInCache(self);
	}
}

- (void)requestFinishedWithResponse:(NSURLResponse *)response data:(NSData *)data
{
	
}

- (void)requestFailedWithResponse:(NSURLResponse *)response error:(NSError *)error
{
	
}


@end
