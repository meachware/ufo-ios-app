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
#import "SGBarButton.h"

typedef enum {
    kMainMode,
    kArticleMode
} SGToolbarMode;

@interface SGMainControllerView ()
- (NSArray *)toolbarItemsForMode:(SGToolbarMode)mode;
@end

@implementation SGMainControllerView

#pragma mark Properties

@synthesize toolBar = _toolBar;
@synthesize navButton = _navButton;
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
		_backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars"]];
		_backgroundView.clipsToBounds = YES;
		
		[self addSubview:_backgroundView];
		
		_bottomBackgroundView = [UIView.alloc init];
		_bottomBackgroundView.backgroundColor = UIColor.blackColor;
		
		[self addSubview:_bottomBackgroundView];
		
		UIButton * navButton = [UIButton buttonWithType:UIButtonTypeCustom];
		navButton.frame = CGRectMake(0, 0, 115, 36);
		[navButton setBackgroundImage:[UIImage imageNamed:@"nav_button"] forState:UIControlStateNormal];
		[navButton setBackgroundImage:[UIImage imageNamed:@"nav_button_on"] forState:UIControlStateHighlighted];
		
		_navButton = [UIBarButtonItem.alloc initWithCustomView:navButton];
		
		_toolBar = toolBar;
		[_toolBar setItems:[self toolbarItemsForMode:kMainMode]];
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
	
	_articleView.frame = CGRectMake(size.width, 45, size.width, size.height - 44);
}

#pragma mark Private Methods

- (NSArray *)toolbarItemsForMode:(SGToolbarMode)mode
{	
	UIBarButtonItem * leftSpaceItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem * rightSpaceItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	if (mode == kMainMode)
	{
		return [NSArray arrayWithObjects:leftSpaceItem, _navButton, rightSpaceItem, nil];
	}
	else if (mode == kArticleMode)
	{
		SGBarButton * backButton = [SGBarButton.alloc initWithType:kBackButtonType];
		[backButton setTitle:@"News" forState:UIControlStateNormal];
		backButton.upInside = ^(){
			[self dismissArticle];
		};
		
		UIBarButtonItem * backButtonItem = [UIBarButtonItem.alloc initWithCustomView:backButton];
		
		SGBarButton * shareButton = [SGBarButton.alloc initWithType:kSharingType];
		shareButton.upInside = ^(){
			
		};
		
		UIBarButtonItem * shareButtonItem = [UIBarButtonItem.alloc initWithCustomView:shareButton];
		
		return [NSArray arrayWithObjects:backButtonItem, leftSpaceItem, _navButton, rightSpaceItem, shareButtonItem, nil];
	}
	
	return [NSArray array];
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
	
	[UIView animateWithDuration:0.3 animations:^{
		
		_backgroundView.frame = CGRectOffset(_backgroundView.frame, 8, 8);
		_pageControlView.frame = CGRectOffset(_pageControlView.frame, 8, -8);
		_pageControllerView.frame = CGRectOffset(_pageControllerView.frame, 8, 6);
		_bottomBackgroundView.frame = CGRectOffset(_bottomBackgroundView.frame, 8, -8);
		
		_articleView.frame = CGRectOffset(_articleView.frame, - 320, 0);
		
		[_toolBar setItems:[self toolbarItemsForMode:kArticleMode]];
		
	} completion:^(BOOL finished){
		
	}];
}

- (void)dismissArticle
{
	[UIView animateWithDuration:0.3 animations:^{
		
		_backgroundView.frame = CGRectOffset(_backgroundView.frame, -8, -8);
		_pageControlView.frame = CGRectOffset(_pageControlView.frame, -8, 8);
		_pageControllerView.frame = CGRectOffset(_pageControllerView.frame, -8, -6);
		_bottomBackgroundView.frame = CGRectOffset(_bottomBackgroundView.frame, -8, 8);
		
		_articleView.frame = CGRectOffset(_articleView.frame, 320, 0);
		
		[_toolBar setItems:[self toolbarItemsForMode:kMainMode]];
		
	} completion:^(BOOL finished){
			
	}];
}

@end
