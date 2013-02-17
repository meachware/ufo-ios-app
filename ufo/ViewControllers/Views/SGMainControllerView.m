//
//  SGMainControllerView.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMainControllerView.h"
#import <QuartzCore/QuartzCore.h>
#import "SGBaseArticle.h"

@implementation SGMainControllerView

#pragma mark Properties

@synthesize toolBar = _toolBar;
@synthesize backgroundView = _backgroundView;
@synthesize bottomBackgroundView = _bottomBackgroundView;
@synthesize pageControllerView = _pageControllerView;
@synthesize pageControlView = _pageControlView;
@synthesize articleView = _articleView;

#pragma mark Initialization

- (id)initWithToolBar:(UIToolbar *)toolBar
{
	self = [super init];
	if (self)
	{
		self.backgroundColor = UIColor.blackColor;
		
		_backgroundView = UIView.alloc.init;
		_backgroundView.backgroundColor = [UIColor grayColor];
		_backgroundView.clipsToBounds = YES;
		
		[self addSubview:_backgroundView];
		
		_bottomBackgroundView = [UIView.alloc init];
		_bottomBackgroundView.backgroundColor = UIColor.blackColor;
		
		[self addSubview:_bottomBackgroundView];
		
		_toolBar = toolBar;
		[self addSubview:_toolBar];
		
		_pageControlView = [SGPageControlView.alloc initWithFrame:CGRectZero];
		[self addSubview:_pageControlView];
	}
	return self;
}

#pragma mark View loading
- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_toolBar.frame = CGRectMake(0, 0, size.width, 45);
	_backgroundView.frame = CGRectMake(0, 44, size.width, size.height - 44);
	_bottomBackgroundView.frame = CGRectMake(0, size.height, size.width, 8);
	_pageControlView.frame = CGRectMake(0, size.height - 22, size.width, 22);
	
	if (_pageControllerView)
	{
		_pageControllerView.frame = CGRectMake(0, 45, size.width, size.height - 64);
	}
	
	_articleView.frame = CGRectMake(size.width, 44, size.width, size.height - 44);
}

#pragma mark Public Methods

- (void)addPageControllerView:(UIView *)pageControllerView
{
	if (!_pageControllerView)
	{
		_pageControllerView = pageControllerView;
		[self insertSubview:_pageControllerView belowSubview:_pageControlView];
		
		[self setNeedsLayout];
	}
}

- (void)setArticleView:(SGArticleView *)articleView
{
	if (_articleView != articleView)
	{
		if (_articleView.superview != nil)
		{
			[_articleView removeFromSuperview];
		}
		
		_articleView = articleView;
		[self addSubview:_articleView];
	}
}

- (void)presentArticle:(SGBaseArticle *)article
{
	_articleView.article = article;
	
	[UIView animateWithDuration:0.5 animations:^{
		
		_backgroundView.frame = CGRectOffset(_backgroundView.frame, 8, 8);
		_pageControlView.frame = CGRectOffset(_pageControlView.frame, 8, -8);
		_pageControllerView.frame = CGRectOffset(_pageControllerView.frame, 8, 6);
		_bottomBackgroundView.frame = CGRectOffset(_bottomBackgroundView.frame, 8, -8);
		
		_articleView.frame = CGRectOffset(_articleView.frame, - 320, 0);
		
		UIBarButtonItem * backButton = [UIBarButtonItem.alloc initWithTitle:@"News" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissArticle)];
		[_toolBar setItems:[NSArray arrayWithObject:backButton]];
		
	} completion:^(BOOL finished){
		
	}];
}

- (void)dismissArticle
{
	[UIView animateWithDuration:0.5 animations:^{
		
		_backgroundView.frame = CGRectOffset(_backgroundView.frame, -8, -8);
		_pageControlView.frame = CGRectOffset(_pageControlView.frame, -8, 8);
		_pageControllerView.frame = CGRectOffset(_pageControllerView.frame, -8, -6);
		_bottomBackgroundView.frame = CGRectOffset(_bottomBackgroundView.frame, -8, 8);
		
		_articleView.frame = CGRectOffset(_articleView.frame, 320, 0);
		
		[_toolBar setItems:nil];
		
	} completion:^(BOOL finished){
			
	}];
}

@end
