//
//  VMRequestManager.h
//  tvgidsios
//
//  Created by Edwin Schaap on 07-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "SGRequestOperation.h"

@class SGArticleRequest;

typedef enum
{
	kSMNetworkStatusNone = 0,
	kSMNetworkStatusWifi,
	kSMNetworkStatusWWAN
} SMNetworkStatus;


@interface SGRequestManager : NSObject
{
@private
	SCNetworkReachabilityRef _reachabilityRef;
	NSDate * _lastNetworkFailure;
	BOOL _notifiedUserAboutNetworkUnavailable;
	BOOL _notifiedUastUserAboutNetworkTimeout;
	NSURLCache * _cache;
	NSOperationQueue * _requestQueue;
}

#pragma mark Singleton pattern
+ (SGRequestManager *)shared;

#pragma mark Properties
@property (nonatomic, strong, readonly) NSURLCache * cache;
@property (nonatomic, strong, readonly) NSOperationQueue * requestQueue;

#pragma mark Public methods
- (SMNetworkStatus)networkStatus;
- (BOOL)isNetworkAvailableForRequest:(SGAbstractRequest *)request withAlert:(BOOL)alert;
- (void)networkRequest:(SGAbstractRequest *)request timedOutWithAlert:(BOOL)alert;

- (void)loadRequestInArticleQueue:(SGArticleRequest *)request prioritized:(BOOL)priority;	// NSOperationQueuePriorityNormal | NSOperationQueuePriorityVeryHigh

/*
- (void)loadRequestInImageQueue:(SGImageRequest *)request prioritized:(BOOL)priority;		// NSOperationQueuePriorityLow | NSOperationQueuePriorityHigh
*/
- (void)cancelRequest:(SGAbstractRequest *)request;

@end
