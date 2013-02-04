//
//  SGImageLoader.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGImageData;

typedef void (^SGImageWaiting) (SGImageData * data, UIImage * image);
typedef void (^SGImageLoading) (SGImageData * data);
typedef void (^SGImageLoaded) (SGImageData * data, UIImage * image, BOOL fromCache);
typedef void (^SGImageFailed) (SGImageData * data);

@interface SGImageLoader : NSObject
{
@private
	SGImageData * _imageData;
	SGImageWaiting _waiting;
	SGImageLoading _loading;
	SGImageLoaded _loaded;
	SGImageFailed _failed;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGImageData * imageData;
@property (nonatomic, copy) SGImageWaiting waiting;
@property (nonatomic, copy) SGImageLoading loading;
@property (nonatomic, copy) SGImageLoaded loaded;
@property (nonatomic, copy) SGImageFailed failed;

#pragma mark Initializer
- (id)initWithImageData:(SGImageData *)imageData;

#pragma mark Public methods
- (void)start;

@end
