//
//  SGImageView.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageView.h"
#import "SGImageLoader.h"

@implementation SGImageView

#pragma mark Properties
@synthesize imageData = _imageData;

#pragma mark Initialization
- (id)initWithImageData:(SGImageData *)imageData
{
	self = [super initWithImage:nil];
	if (self)
	{
		_imageData = imageData;
		
		[self loadImage];
	}
	return self;
}

#pragma mark Private methods

- (void)loadImage
{
	SGImageLoader * loader = [SGImageLoader.alloc initWithImageData:_imageData];
	
	loader.waiting = ^(SGImageData * data, UIImage * image) {
		
	};
	
	loader.loading = ^(SGImageData * data) {
		
	};
	
	loader.loaded = ^(SGImageData * data, UIImage * image, BOOL fromCache) {
		
		self.image = image;
	};
	
	loader.failed = ^(SGImageData * data) {
	
	};
	
	[loader start];
}

@end
