//
//  SGArticleCell.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleCell.h"
#import "SGImageView.h"
#import "SGBaseArticle.h"
#import "SGImageData.h"
#import "SGImageType.h"
#import "SGStyle.h"

@implementation SGArticleCell

#pragma mark Properties

@synthesize thumbImageView = _thumbImageView;
@synthesize titleLabel = _titleLabel;
@synthesize article = _article;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		UIImage * backgroundImage = [UIImage imageNamed:@"cell_background"];
		UIImageView * backgroundView = [UIImageView.alloc initWithImage:backgroundImage];
		self.backgroundView = backgroundView;
		
		_titleLabel = UILabel.alloc.init;
		_titleLabel.backgroundColor = UIColor.clearColor;
		_titleLabel.numberOfLines = 2;
		_titleLabel.font = SGStyle.articleCellStyle.font;
		_titleLabel.textColor = SGStyle.articleCellStyle.color;
		
		[self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGSize imageSize = SGImageType.thumbImageType.size;
	_thumbImageView.frame = CGRectMake(4, 6, imageSize.width, imageSize.height);
	_titleLabel.frame = CGRectMake(CGRectGetMaxX(_thumbImageView.frame) + 10, 2, 190, imageSize.height);
}

- (void)setArticle:(SGBaseArticle *)article
{
	if (_article != article)
	{
		_article = article;
		
		if (_thumbImageView)
		{
			[_thumbImageView removeFromSuperview];
			_thumbImageView = nil;
		}
		
		SGImageData * imageData = [SGImageData.alloc initWithPath:_article.thumbUrl type:SGImageType.thumbImageType];
		_thumbImageView = [SGImageView.alloc initWithImageData:imageData];
		[self.contentView addSubview:_thumbImageView];
		
		_titleLabel.text = article.title;
	}
}

@end
