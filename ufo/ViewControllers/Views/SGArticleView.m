//
//  SGArticleView.m
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleView.h"
#import "SGBaseArticle.h"

@implementation SGArticleView

#pragma mark Properties
@synthesize article = _article;

- (id)initWithArticle:(SGBaseArticle *)article
{
	self = [super init];
	if (self)
	{
		_article = article;
	}
	return self;
}


#pragma mark View loading

- (void)layoutSubviews
{
	
}

#pragma mark Public Methods

- (void)setArticle:(SGBaseArticle *)article
{
	if (_article != article)
	{
		_article = article;
		
		[self setNeedsDisplay];
	}
}

@end
