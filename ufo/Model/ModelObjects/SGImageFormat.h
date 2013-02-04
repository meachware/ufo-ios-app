//
//  SGImageFormat.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGImageFormat : NSObject
{
@private
	NSString * _code;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) NSString * code;

#pragma mark Class methods
+ (SGImageFormat *)png;
+ (SGImageFormat *)jpeg;
+ (SGImageFormat *)gif;
+ (SGImageFormat *)tiff;

+ (SGImageFormat *)formatByMimeType:(NSString *)mimeType;
+ (SGImageFormat *)formatByData:(NSData *)data;

#pragma mark Public methods
- (NSData *)dataFromImage:(UIImage *)image;

@end
