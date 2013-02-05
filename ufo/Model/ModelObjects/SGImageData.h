//
//  SGImageData.h
//  ufo
//
//  Created by SandGro on 04-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGImageType;

@interface SGImageData : NSObject
{
@private
	NSString * _path;
	NSString * _cacheKey;
	SGImageType * _type;
}

@property (nonatomic, readonly, strong) NSString * path;
@property (nonatomic, readonly, strong) NSString * cacheKey;
@property (nonatomic, readonly, strong) SGImageType * type;

-(id)initWithPath:(NSString *)path type:(SGImageType *)type;

@end
