//
//  SGRequestOperation.h
//  ufo
//
//  Created by SandGro on 17-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGAbstractRequest;

@interface SGRequestOperation : NSOperation <NSURLConnectionDelegate>
{
@private
	SGAbstractRequest * _request;
	NSURLResponse * _response;
	NSURLConnection * _connection;
	NSMutableData * _data;
    NSOperationQueue * _queue;
	NSRunLoop * _runLoop;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) SGAbstractRequest * request;
@property (nonatomic, strong, readonly) NSURLResponse * response;

#pragma mark Initialization
- (id)initWithRequest:(SGAbstractRequest *)request queue:(NSOperationQueue *)queue;

#pragma mark Class methods
+ (SGRequestOperation *)startWithRequest:(SGAbstractRequest *)request queue:(NSOperationQueue *)queue priority:(NSOperationQueuePriority)priority;

#pragma mark Public methods
- (void)startRequest;

@end
