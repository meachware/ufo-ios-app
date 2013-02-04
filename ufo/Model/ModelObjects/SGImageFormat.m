//
//  SGImageFormat.m
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGImageFormat.h"

@implementation SGImageFormat

#pragma mark Properties

@synthesize code = _code;

#pragma mark Initialization

- (id)initWithCode:(NSString *)code
{
	self = [super init];
	if (self)
	{
		_code = code;
	}
	return self;
}

#pragma mark Class methods

+ (SGImageFormat *)png
{
	static SGImageFormat * format = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		format = [SGImageFormat.alloc initWithCode:@"png"];
	});
	
	return format;
}

+ (SGImageFormat *)jpeg
{
	static SGImageFormat * format = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		format = [SGImageFormat.alloc initWithCode:@"jpeg"];
	});
	
	return format;
}

+ (SGImageFormat *)gif
{
	static SGImageFormat * format = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		format = [SGImageFormat.alloc initWithCode:@"gif"];
	});
	
	return format;
}

+ (SGImageFormat *)tiff
{
	static SGImageFormat * format = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		format = [SGImageFormat.alloc initWithCode:@"tiff"];
	});
	
	return format;
}


+ (SGImageFormat *)formatByMimeType:(NSString *)mimeType
{
	SGImageFormat * format = nil;
	
	if ([@"image/png" isEqualToString:mimeType])
	{
		format = SGImageFormat.png;
	}
	else if ([@"image/jpg" isEqualToString:mimeType] || [@"image/jpeg" isEqualToString:mimeType])
	{
		format = SGImageFormat.jpeg;
	}
	else if ([@"image/gif" isEqualToString:mimeType])
	{
		format = SGImageFormat.gif;
	}
	else if ([@"image/tiff" isEqualToString:mimeType])
	{
		format = SGImageFormat.tiff;
	}
	
	return format;
}

+ (SGImageFormat *)formatByData:(NSData *)data
{
	SGImageFormat * format = nil;
	
	if (data.length > 4)
	{
		unsigned char sign[4];
		[data getBytes:&sign length:4];
		
		if (sign[0] == 0x89 && sign[1] == 0x50 && sign[2] == 0x4E && sign[3] == 0x47)
		{
			format = SGImageFormat.png;
		}
		else if (sign[0] == 0xFF && sign[1] == 0xD8 && sign[2] == 0xFF && sign[3] == 0xE0)
		{
			format = SGImageFormat.jpeg;
		}
		else if (sign[0] == 0x47 && sign[1] == 0x49 && sign[2] == 0x46 && sign[3] == 0x38)
		{
			format = SGImageFormat.gif;
		}
		else if ((sign[0] == 0x49 && sign[1] == 0x49 && sign[2] == 0x2A && sign[3] == 0x00) ||
				 (sign[0] == 0x4D && sign[1] == 0x4D && sign[2] == 0x00 && sign[3] == 0x2A))
		{
			format = SGImageFormat.tiff;
		}
	}
	
	return format;
}

#pragma mark Public methods

- (NSData *)dataFromImage:(UIImage *)image
{
	NSData * data = nil;
	
	if (self == SGImageFormat.png)
	{
		data = UIImagePNGRepresentation(image);
	}
	else if (self == SGImageFormat.jpeg)
	{
		data = UIImageJPEGRepresentation(image, 0.8);
	}
	else if (self == SGImageFormat.gif)
	{
		data = UIImagePNGRepresentation(image);
	}
	else if (self == SGImageFormat.tiff)
	{
		data = UIImageJPEGRepresentation(image, 0.8);
	}
	
	return data;
}

@end

