//
//  SGAbstractRequest.h
//  ufo
//
//  Created by SandGro on 17-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGAbstractRequest;

typedef void (^SGRequestNotInCache)(SGAbstractRequest * request);
typedef void (^SGRequestFinished)(SGAbstractRequest * request, NSData * data);
typedef void (^SGRequestFailed)(SGAbstractRequest * request, NSHTTPURLResponse * httpResponse, NSError * error);

@interface SGAbstractRequest : NSMutableURLRequest
{
@protected
	SGRequestNotInCache _requestNotInCache;
	SGRequestFinished _requestFinished;
	SGRequestFailed _requestFailed;
	BOOL _alertToUser;
}

#pragma mark Properties
@property (nonatomic, copy) SGRequestNotInCache requestNotInCache;
@property (nonatomic, copy) SGRequestFinished requestFinished;
@property (nonatomic, copy) SGRequestFailed requestFailed;
@property (nonatomic, assign, getter = willAlertToUser) BOOL alertToUser;

#pragma mark Class methods
+ (NSString *)sgHostName;
+ (NSString *)sgStaticImageHostName;

#pragma mark Operation methods
- (BOOL)hasCachedResponse;
- (void)requestNotFoundInCache;
- (void)requestFinishedWithResponse:(NSURLResponse *)response data:(NSData *)data;
- (void)requestFailedWithResponse:(NSURLResponse *)response error:(NSError *)error;



@end
