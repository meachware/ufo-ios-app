//
//  SGImageType.h
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SGThumbImageTypeCode;
extern NSString * const SGDetailImageTypeCode;

@interface SGImageType : NSObject
{
@private
	CGSize _size;
	NSString * _code;
}

#pragma mark Properties
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly, strong) NSString * code;

#pragma Public Class methods
+ (SGImageType *)thumbImageType;
+ (SGImageType *)detailImageType;
@end
