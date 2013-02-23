//
//  SGArticleView.h
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGBaseArticle;
@class SGMediaGalleryView;

@interface SGArticleView : UIScrollView
{
@private
	SGBaseArticle * _article;
	SGMediaGalleryView * _mediaGalleryView;
	UILabel * _titleLabel;
	UILabel * _paragraphTextLabel;
	UILabel * _publishDateLabel;
}

#pragma mark Properties
@property (nonatomic, readwrite, strong) SGBaseArticle * article;
@property (nonatomic, readonly, strong) SGMediaGalleryView * mediaGalleryView;
@property (nonatomic, readonly, strong) UILabel * titleLabel;
@property (nonatomic, readonly, strong) UILabel * publishDateLabel;
@property (nonatomic, readonly, strong) UILabel * paragraphTextLabel;

@end
