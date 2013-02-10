//
//  SGArticleView.m
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleView.h"
#import "SGBaseArticle.h"
#import "SGMediaGalleryView.h"

@implementation SGArticleView

#pragma mark Properties
@synthesize article = _article;
@synthesize mediaGalleryView = _mediaGalleryView;
@synthesize paragraphTextLabel = _paragraphTextLabel;

- (id)init
{
	self = [super init];
	if (self)
	{
		_article = nil;
		
		self.backgroundColor = UIColor.whiteColor;
		
		_mediaGalleryView = [SGMediaGalleryView.alloc initWithFrame:CGRectZero mediaViews:nil];
		
		_paragraphTextLabel = UILabel.alloc.init;
		_paragraphTextLabel.textColor = UIColor.blackColor;
		_paragraphTextLabel.numberOfLines = 0;
		_paragraphTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
		
		[self addSubview:_paragraphTextLabel];
	}
	return self;
}


#pragma mark View loading

- (void)layoutSubviews
{
	_paragraphTextLabel.frame = CGRectMake(0, 0, 300, 400);
}

#pragma mark Public Methods

- (void)setArticle:(SGBaseArticle *)article
{
	if (_article != article)
	{
		_article = article;
		
		_paragraphTextLabel.text = _article.text;
		
		[self setNeedsDisplay];
	}
}

@end
