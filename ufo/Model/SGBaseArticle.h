//
//  SGBaseArticle.h
//  ufo
//
//  Created by SandGro on 13-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGBaseArticle : NSObject
{
@private
	NSString * _title;
	NSDate * _publishDate;
	NSString * _text;
	BOOL _active;
}

@property (nonatomic, readonly, strong) NSString * title;
@property (nonatomic, readonly, strong) NSDate * publishDate;
@property (nonatomic, readonly, strong) NSString * text;
@property (nonatomic, readonly) BOOL active;

@end
