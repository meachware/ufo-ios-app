//
//  SGArticleCell.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGImageView;
@class SGBaseArticle;

@interface SGArticleCell : UITableViewCell
{
@private
	SGImageView * _thumbImageView;
	UILabel * _titleLabel;
	SGBaseArticle * _article;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGImageView * thumbImageView;
@property (nonatomic, readonly, strong) UILabel * titleLabel;
@property (nonatomic, readwrite, strong) SGBaseArticle * article;

@end
