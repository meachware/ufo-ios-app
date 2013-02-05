//
//  SGImageData.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageData.h"

@implementation SGImageData

@synthesize path = _path;
@synthesize cacheKey = _cacheKey;
@synthesize type = _type;

-(id)initWithPath:(NSString *)path type:(SGImageType *)type
{
	self = [super init];
	if (self)
	{
		_path = path;
		_type = type;
	}
	return self;
}

- (NSString *)cacheKey
{
	return [_path lastPathComponent];
}

@end
