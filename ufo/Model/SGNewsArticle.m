//
//  SGNewsArticle.m
//  ufo
//
//  Created by SandGro on 17-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGNewsArticle.h"
#import "NSDictionary+Json.h"

@implementation SGNewsArticle

#pragma mark Public Methods
- (void)updateWithServedJson:(NSDictionary *)json
{
	_title = [json stringForKey:@"title"];
	_text = [json stringForKey:@"text"];
	_publishDate = [json dateForTestedKey:@"publish_date"];
}

@end
