//
//  SGImageView.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGImageData;

@interface SGImageView : UIImageView
{
@private
	SGImageData * _imageData;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGImageData * imageData;

#pragma mark Initialization
- (id)initWithImageData:(SGImageData *)imageData;

@end
