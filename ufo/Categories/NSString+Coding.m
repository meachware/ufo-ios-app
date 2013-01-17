//
//  NSString+Coding.m
//  tvgidsios
//
//  Created by Edwin Schaap on 17-12-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "NSString+Coding.h"


@implementation NSString (Coding)

#pragma mark Public methods

- (NSString *)stringByAddingPercentEscapes
{
	NSMutableString * output = [NSMutableString.alloc init];
	
	const unsigned char * source = (const unsigned char *)self.UTF8String;
	
	int sourceLen = strlen((const char *)source);
	
	for (int i = 0; i < sourceLen; ++i)
	{
		const unsigned char c = source[i];
		
		if (c == ' ')
		{
			[output appendString:@"+"];
		}
		else if (c == '.' || c == '-' || c == '_' || c == '~' || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
		{
			[output appendFormat:@"%c", c];
		}
		else
		{
			[output appendFormat:@"%%%02X", c];
		}
	}
	
	return output;
}

@end
