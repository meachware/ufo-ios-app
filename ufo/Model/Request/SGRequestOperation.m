//
//  SGRequestOperation.m
//  ufo
//
//  Created by SandGro on 17-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGRequestOperation.h"
#import "SGAbstractRequest.h"
#import "SGRequestManager.h"

@interface SGRequestOperation ()

#pragma mark Private class methods
+ (void)updateNetworkActivityIndicator:(NSInteger)delta;

@end

@implementation SGRequestOperation

#pragma mark Properties

@synthesize request = _request;
@synthesize response = _response;

#pragma mark Initialization

- (id)initWithRequest:(SGAbstractRequest *)request queue:(NSOperationQueue *)queue
{
	self = [super init];
	if (self)
	{
		_request = request;
		_response = nil;
		_connection = nil;
		_data = nil;
		_queue = queue;
		_runLoop = nil;
	}
	return self;
}

#pragma mark Class methods

+ (SGRequestOperation *)startWithRequest:(SGAbstractRequest *)request queue:(NSOperationQueue *)queue priority:(NSOperationQueuePriority)priority
{
	SGRequestOperation * operation = [SGRequestOperation.alloc initWithRequest:request queue:queue];
	operation.queuePriority = priority;
	[operation startRequest];
	return operation;
}

#pragma mark Public methods

- (void)startRequest
{
	dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(globalQueue, ^{
		@autoreleasepool
		{
			if (![_request hasCachedResponse])
			{
				dispatch_async(dispatch_get_main_queue(), ^{
					[_request requestNotFoundInCache];
				});
				[_queue addOperation:self];
			}
		}
	});
}

#pragma mark Overwritten methods

- (void)main
{
	@autoreleasepool
	{
		if (!self.isCancelled && ![_request hasCachedResponse])
		{
			if ([SGRequestManager.shared isNetworkAvailableForRequest:_request withAlert:_request.alertToUser])
			{
				[SGRequestOperation updateNetworkActivityIndicator:1];
				
				if ([NSURLConnection canHandleRequest:_request])
				{
					_connection = [NSURLConnection.alloc initWithRequest:_request delegate:self startImmediately:NO];
					[_connection start];
					
					_runLoop = NSRunLoop.currentRunLoop;
					
					while (!self.isCancelled && [_runLoop runMode:NSDefaultRunLoopMode beforeDate:NSDate.distantFuture]);
					
					if (self.isCancelled)
					{
						NSLog(@"Operation for request %@ is cancelled.", _request.description);
						[_connection cancel];
					}
				}
				else
				{
					NSError * error = [NSError.alloc initWithDomain:@"Invalid URL" code:0 userInfo:nil];
					[_request requestFailedWithResponse:_response error:error];
				}
				
				[SGRequestOperation updateNetworkActivityIndicator:-1];
			}
		}
	}
}

- (void)cancel
{
	[super cancel];
	
	CFRunLoopRef runLoopRef = _runLoop.getCFRunLoop;
	if (runLoopRef)
	{
		CFRunLoopStop(runLoopRef);
	}
}

#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[_request requestFailedWithResponse:_response error:error];
}

#pragma mark NSURLConnectionData delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_response = response;
	_data = [NSMutableData.alloc initWithLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[_request requestFinishedWithResponse:_response data:_data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	return nil;
}

#pragma mark Private class methods

+ (void)updateNetworkActivityIndicator:(NSInteger)delta
{
	static NSInteger activities = 0;
	
	activities += delta;
	if (activities < 0)
	{
		activities = 0;
		NSLog(@"Request operation below 0");
	}
	
	UIApplication.sharedApplication.networkActivityIndicatorVisible = activities > 0;
}

@end
