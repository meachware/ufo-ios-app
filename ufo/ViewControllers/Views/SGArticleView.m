//
//  SGArticleView.m
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleView.h"
#import "SGBaseArticle.h"
#import "SGImageType.h"
#import "NSDate+ISO8601.h"

@interface SGArticleView ()
- (void)handleSwipe;
@end

@implementation SGArticleView

#pragma mark Properties
@synthesize article = _article;
@synthesize mediaGalleryView = _mediaGalleryView;
@synthesize titleLabel = _titleLabel;
@synthesize publishDateLabel = _publishDateLabel;
@synthesize paragraphTextLabel = _paragraphTextLabel;
@synthesize articleViewSwiped = _articleViewSwiped;

- (id)init
{
	self = [super init];
	if (self)
	{
		_article = nil;
		
		self.backgroundColor = UIColor.whiteColor;
		
		_mediaGalleryView = [SGMediaGalleryView.alloc initWithImageType:SGImageType.galleryImageLargeType];
		[self addSubview:_mediaGalleryView];
		
		_titleLabel = UILabel.alloc.init;
		_titleLabel.textColor = UIColor.blackColor;
		_titleLabel.numberOfLines = 2;
		_titleLabel.textAlignment = NSTextAlignmentLeft;
		_titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
		[self addSubview:_titleLabel];
		
		_publishDateLabel = UILabel.alloc.init;
		_publishDateLabel.textColor = [UIColor lightGrayColor];
		_publishDateLabel.numberOfLines = 1;
		_publishDateLabel.textAlignment = NSTextAlignmentLeft;
		_publishDateLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
		[self addSubview:_publishDateLabel];
		
		_paragraphTextLabel = UILabel.alloc.init;
		_paragraphTextLabel.textColor = UIColor.blackColor;
		_paragraphTextLabel.numberOfLines = 0;
		_paragraphTextLabel.textAlignment = NSTextAlignmentLeft;
		_paragraphTextLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
		[self addSubview:_paragraphTextLabel];
		
		UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe)];
		[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
		[self addGestureRecognizer:recognizer];
	}
	return self;
}


#pragma mark View loading

- (void)layoutSubviews
{
	CGFloat vOffset = 20;
	CGFloat labelWidth = self.bounds.size.width - 30;
	
	_mediaGalleryView.frame = CGRectMake(0, 0, _mediaGalleryView.imageType.size.width, _mediaGalleryView.imageType.size.height);
	vOffset += CGRectGetMaxY(_mediaGalleryView.frame);
	
	_titleLabel.frame = CGRectMake(10, vOffset, labelWidth, 30);
	[_titleLabel sizeToFit];
	vOffset += CGRectGetHeight(_titleLabel.frame);
	
	_publishDateLabel.frame = CGRectMake(10, vOffset, labelWidth, 30);
	vOffset += CGRectGetHeight(_publishDateLabel.frame);
	
	_paragraphTextLabel.frame = CGRectMake(10, vOffset, labelWidth, self.bounds.size.height - vOffset);
	[_paragraphTextLabel sizeToFit];
	vOffset += CGRectGetHeight(_paragraphTextLabel.frame);
	
	self.contentSize = CGSizeMake(self.bounds.size.width, vOffset);
}

#pragma mark Public Methods

- (void)setArticle:(SGBaseArticle *)article
{
	if (_article != article)
	{
		_article = article;
		
		_mediaGalleryView.imageGallery = _article.imageGallery;
		
		_titleLabel.text = _article.title;
		_publishDateLabel.text = [NSString stringWithFormat:@"Last updated at %@", [_article.publishDate relativeTime]];
		
		_paragraphTextLabel.attributedText = [self formattedText:_article.text];
		[_paragraphTextLabel sizeToFit];
		
		[self setContentOffset:CGPointZero animated:NO];
		
		[self setNeedsDisplay];
	}
}

#pragma mark Private Methods

- (NSAttributedString *)formattedText:(NSString *)text
{
	NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:text];
	NSInteger _stringLength = [text length];
	
	UIColor * _black = [UIColor blackColor];
	UIFont * font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
	
	[attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
	[attString addAttribute:NSForegroundColorAttributeName value:_black range:NSMakeRange(0, _stringLength)];
	
	NSMutableParagraphStyle * mpStyle = NSMutableParagraphStyle.alloc.init;
	mpStyle.paragraphSpacing = 2;
	
	[attString addAttribute:NSParagraphStyleAttributeName value:mpStyle range:NSMakeRange(0, _stringLength)];
	
	//Bold Text
	NSRange startRange = NSMakeRange(0, text.length);
	NSRange bBeginRange = [text rangeOfString:@"<b>" options:NSLiteralSearch range:startRange];
	
	while (bBeginRange.location != NSNotFound)
	{
		NSRange bEndRange = [text rangeOfString:@"</b>" options:NSLiteralSearch range:startRange];
		
		UIFont * fontBold = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
		
		CGFloat beginOffset = bBeginRange.location + bBeginRange.length;
		CGFloat endOffSet = bEndRange.location - beginOffset;
		
		[attString addAttribute:NSFontAttributeName value:fontBold range:NSMakeRange(beginOffset, endOffSet)];
		
		[attString deleteCharactersInRange:bEndRange];
		[attString deleteCharactersInRange:bBeginRange];
		
		text = [text stringByReplacingCharactersInRange:bEndRange withString:@""];
		text = [text stringByReplacingCharactersInRange:bBeginRange withString:@""];
		
		startRange = NSMakeRange(0, text.length);
		bBeginRange = [text rangeOfString:@"<b>" options:NSLiteralSearch range:startRange];
	}
	return attString;
}

- (void)handleSwipe
{
	if (_articleViewSwiped)
	{
		_articleViewSwiped();
	}
}

#pragma mark SGMediaGalleryViewDelegate

- (void)mediaGalleryViewTabbed:(SGMediaGalleryView *)view
{
	
}

@end
