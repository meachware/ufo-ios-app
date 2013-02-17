//
//  SGStyles.m
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGStyle.h"

@implementation SGStyle

#pragma mark Properties

@synthesize font = _font;
@synthesize color = _color;

#pragma mark Public Class methods

+ (SGStyle *)articleCellStyle
{
	static SGStyle * style = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		style = SGStyle.alloc.init;
		style.font = [UIFont fontWithName:@"Helvetica" size:14];
		style.color = UIColor.blackColor;
	});
	
	return style;
}

+ (SGStyle *)tableHeaderTextStyle
{
	static SGStyle * style = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		style = SGStyle.alloc.init;
		style.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
		style.color = [UIColor darkGrayColor];
	});
	
	return style;
}

@end
