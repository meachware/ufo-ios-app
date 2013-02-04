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

-(id)initWithPath:(NSString *)path
{
	self = [super init];
	if (self)
	{
		_path = path;
	}
	return self;
}

- (NSString *)cacheKey
{
	return [_path lastPathComponent];
}

@end
