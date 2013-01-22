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
@protected
	NSString * _title;
	NSDate * _publishDate;
	NSString * _text;
}

@property (nonatomic, readonly, strong) NSString * title;
@property (nonatomic, readonly, strong) NSDate * publishDate;
@property (nonatomic, readonly, strong) NSString * text;

#pragma mark Public Methods
- (void)updateWithServedJson:(NSDictionary *)json;

@end
