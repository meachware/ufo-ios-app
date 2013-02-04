//
//  VMRequestManager.m
//  tvgidsios
//
//  Created by Edwin Schaap on 07-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "SGRequestManager.h"
#import "SGRequestOperation.h"
#import "SGAbstractRequest.h"
#import "SGArticleRequest.h"

@implementation SGRequestManager

#pragma mark Singleton pattern

+ (SGRequestManager *)shared
{
	static SGRequestManager * shared;
	
	static dispatch_once_t done;
	dispatch_once(&done, ^{
		shared = [SGRequestManager.alloc init];
	});
	
	return shared;
}

#pragma mark Properties

@synthesize cache = _cache;
@synthesize requestQueue = _requestQueue;

#pragma mark Initialization

- (id)init
{
	self = [super init];
    if (self)
	{
		struct sockaddr_in zeroAddress;
		bzero(&zeroAddress, sizeof(zeroAddress));
		zeroAddress.sin_len = sizeof(zeroAddress);
		zeroAddress.sin_family = AF_INET;
		_reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
		
		_lastNetworkFailure = NSDate.distantPast;
		_notifiedUserAboutNetworkUnavailable = NO;
		_notifiedUastUserAboutNetworkTimeout = NO;
		
		_cache = [NSURLCache.alloc initWithMemoryCapacity:1024 * 1024 * 8 diskCapacity:1024 * 1024 * 64 diskPath:@"dataCache"];
		NSURLCache.sharedURLCache = _cache;
		
		_requestQueue = [NSOperationQueue.alloc init];
		_requestQueue.maxConcurrentOperationCount = 8;
	}
	
	return self;
}

- (void)dealloc
{
	if (_reachabilityRef)
	{
		CFRelease(_reachabilityRef);
		_reachabilityRef = NULL;
	}
}

#pragma mark Public methods

- (SMNetworkStatus)networkStatus
{
	SMNetworkStatus status = kSMNetworkStatusNone;
	SCNetworkReachabilityFlags flags = 0;
	
	if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
	{
		if (flags & kSCNetworkReachabilityFlagsReachable)
		{
			if (flags & kSCNetworkReachabilityFlagsIsWWAN)
			{
				// Clear moot bits.
				flags &= ~kSCNetworkReachabilityFlagsReachable;
				flags &= ~kSCNetworkReachabilityFlagsIsDirect;
				flags &= ~kSCNetworkReachabilityFlagsIsLocalAddress;
				
				// Reachability Flag Status: -R ct---xx Connection down.
				if (flags != (kSCNetworkReachabilityFlagsConnectionRequired | kSCNetworkReachabilityFlagsTransientConnection))
				{
					// Reachability Flag Status: -R -t---xx Reachable. WiFi + VPN(is up)
					// Reachability Flag Status: -R cxxxxxx Reachable.
					// Reachability Flag Status: -R -----xx Reachable.
					if ((flags & kSCNetworkReachabilityFlagsTransientConnection) ||
						(flags & kSCNetworkReachabilityFlagsConnectionRequired) ||
						flags == 0)
					{
						status = kSMNetworkStatusWWAN;
					}
				}
			}
			else
			{
				status = kSMNetworkStatusWifi;
			}
		}
	}
	
	return status;
}

- (BOOL)isNetworkAvailableForRequest:(SGAbstractRequest *)request withAlert:(BOOL)alert
{
	BOOL hasNet = self.networkStatus != kSMNetworkStatusNone;
	
	if (hasNet)
	{
		if ([NSDate.date timeIntervalSinceDate:_lastNetworkFailure] > 60 * 5)
		{
			_notifiedUserAboutNetworkUnavailable = NO;
			_notifiedUastUserAboutNetworkTimeout = NO;
		}
	}
	else
	{
		_lastNetworkFailure = NSDate.date;
		
		if (!_notifiedUserAboutNetworkUnavailable)
		{
			_notifiedUserAboutNetworkUnavailable = YES;
			
			NSLog(@"No network for request %@.", request.URL);
			
			if (alert)
			{
				dispatch_async(dispatch_get_main_queue(), ^{
					
				});
			}
		}
	}
	
	return hasNet;
}

- (void)networkRequest:(SGAbstractRequest *)request timedOutWithAlert:(BOOL)alert
{
	_lastNetworkFailure = NSDate.date;
	
	if (!_notifiedUastUserAboutNetworkTimeout)
	{
		_notifiedUastUserAboutNetworkTimeout = YES;
		
		NSLog(@"Request %@ timed out.", request.URL);
		
		if (alert)
		{
			dispatch_async(dispatch_get_main_queue(), ^{
				
			});
		}
	}
}


- (void)loadRequestInArticleQueue:(SGArticleRequest *)request prioritized:(BOOL)priority
{
	[SGRequestOperation startWithRequest:request queue:_requestQueue priority:priority ? NSOperationQueuePriorityVeryHigh : NSOperationQueuePriorityNormal];
}

- (void)loadRequestInImageQueue:(SGImageRequest *)request prioritized:(BOOL)priority
{
	[SGRequestOperation startWithRequest:request queue:_requestQueue priority:priority ? NSOperationQueuePriorityHigh : NSOperationQueuePriorityLow];
}


- (void)cancelRequest:(SGAbstractRequest *)request
{
	for (SGRequestOperation * operation in _requestQueue.operations)
	{
		if (operation.request == request)
		{
			[operation cancel];
			break;
		}
	}
}

#pragma mark Property implementations

- (NSURLCache *)cache
{
	//	NSLog(@"Cache memory usage %d, disk usage %d)", _cache.currentMemoryUsage, _cache.currentDiskUsage);
	return _cache;
}

@end
