//
//  SGStyles.h
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGStyle : NSObject
{
@private
	UIFont * _font;
	UIColor * _color;
}

#pragma mark Properties
@property (nonatomic, readwrite, strong) UIFont * font;
@property (nonatomic, readwrite, strong) UIColor * color;

+ (SGStyle *)articleCellStyle;
+ (SGStyle *)tableHeaderTextStyle;

@end
