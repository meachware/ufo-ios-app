//
//  SGImageCache.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGImageData;

@interface SGImageCache : NSObject
{
@private
	NSMutableDictionary * _cachedImages;
	NSURL * _imageCacheDirectory;
}

#pragma mark Singleton pattern
+ (SGImageCache *)shared;

#pragma mark Public Methods
@property (nonatomic, readonly, strong) NSMutableDictionary * cachedImages;
@property (nonatomic, readonly, strong) NSURL * imageCacheDirectory;

#pragma mark Public Methods
- (NSURL *)imageCacheDirectoryForImageData:(SGImageData *)imageData;
- (UIImage *)imageFromCacheForImageData:(SGImageData *)imageData;

@end
