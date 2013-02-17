//
//  SGMainControllerView.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGPageControlView.h"
#import "SGArticleView.h"

@class SGBaseArticle;

@interface SGMainControllerView : UIView
{
@private
	UIToolbar * _toolBar;
	UIBarButtonItem * _navButton;
	UIView * _backgroundView;
	UIView * _bottomBackgroundView;
	UIView * _pageControllerView;
	SGArticleView * _articleView;
	SGPageControlView * _pageControlView;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) UIToolbar * toolBar;
@property (nonatomic, strong, readonly) UIBarButtonItem * navButton;
@property (nonatomic, strong, readonly) UIView * backgroundView;
@property (nonatomic, strong, readonly) UIView * bottomBackgroundView;
@property (nonatomic, strong, readonly) UIView * pageControllerView;
@property (nonatomic, strong, readwrite) SGArticleView * articleView;
@property (nonatomic, strong, readonly) SGPageControlView * pageControlView;

#pragma mark Initialization
- (id)initWithToolBar:(UIToolbar *)toolBar;

#pragma mark Public Methods
- (void)addPageControllerView:(UIView *)pageControllerView;
- (void)presentArticle:(SGBaseArticle *)article;
@end
