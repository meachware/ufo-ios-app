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
		
		_mediaGalleryView = [SGMediaGalleryView.alloc initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
		[self addSubview:_mediaGalleryView];
		
		_paragraphTextLabel = UILabel.alloc.init;
		_paragraphTextLabel.textColor = UIColor.blackColor;
		_paragraphTextLabel.numberOfLines = 0;
		_paragraphTextLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
		
		[self addSubview:_paragraphTextLabel];
	}
	return self;
}


#pragma mark View loading

- (void)layoutSubviews
{
	_mediaGalleryView.frame = CGRectMake(0, 0, self.bounds.size.width, 150);
	_paragraphTextLabel.frame = CGRectMake(0, CGRectGetMaxY(_mediaGalleryView.frame) + 20, self.bounds.size.width, 300);
}

#pragma mark Public Methods

- (void)setArticle:(SGBaseArticle *)article
{
	if (_article != article)
	{
		_article = article;
		
		_mediaGalleryView.imageGallery = _article.imageGallery;
		
		_paragraphTextLabel.text = _article.text;
		
		[self setNeedsDisplay];
	}
}

@end
