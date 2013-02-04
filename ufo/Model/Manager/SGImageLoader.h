//
//  SGImageLoader.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGImageData;

@interface SGImageLoader : NSObject
{
@private
	SGImageData * _imageData;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGImageData * imageData;

#pragma mark Initializer
- (id)initWithImageData:(SGImageData *)imageData;

#pragma mark Public methods
- (void)start;

@end
