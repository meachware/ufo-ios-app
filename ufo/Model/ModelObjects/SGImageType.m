//
//  SGImageType.m
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageType.h"

NSString * const SGThumbImageTypeCode = @"thumbImageTypeCode";
NSString * const SGGalleryImageSmallTypeCode = @"galleryImageSmallTypeCode";
NSString * const SGGalleryImageLargeTypeCode = @"galleryImageLargeTypeCode";

@implementation SGImageType

#pragma mark Properties

@synthesize size = _size;
@synthesize code = _code;

- (id)initWithSize:(CGSize)size code:(NSString *)code
{
	self = [super init];
	if (self)
	{
		_size = size;
		_code = code;
	}
	return self;
}

+ (SGImageType *)thumbImageType
{
	static SGImageType * type = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		type = [SGImageType.alloc initWithSize:CGSizeMake(100, 56) code:SGThumbImageTypeCode];
	});
	
	return type;
}

+ (SGImageType *)galleryImageSmallType
{
	static SGImageType * type = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		type = [SGImageType.alloc initWithSize:CGSizeMake(320, 120)code:SGGalleryImageSmallTypeCode];
	});
	
	return type;
}

+ (SGImageType *)galleryImageLargeType
{
	static SGImageType * type = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		type = [SGImageType.alloc initWithSize:CGSizeMake(320, 360)code:SGGalleryImageLargeTypeCode];
	});
	
	return type;
}

@end
