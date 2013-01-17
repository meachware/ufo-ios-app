//
//  SGMainControllerView.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMainControllerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SGMainControllerView

#pragma mark Properties

@synthesize navigationView = _navigationView;
@synthesize backgroundView = _backgroundView;
@synthesize bottomBackgroundView = _bottomBackgroundView;
@synthesize pageControllerView = _pageControllerView;
@synthesize pageControlView = _pageControlView;
@synthesize articleView = _articleView;

#pragma mark Initialization

- (id)initWithNavigationView:(UIView *)navigationView
{
	self = [super init];
	if (self)
	{
		self.backgroundColor = UIColor.blackColor;
		
		_navigationView = navigationView;
		[self addSubview:_navigationView];
		
		_backgroundView = UIView.alloc.init;
		_backgroundView.backgroundColor = [UIColor grayColor];
		_backgroundView.clipsToBounds = YES;
		
		[self addSubview:_backgroundView];
		
		_bottomBackgroundView = [UIView.alloc init];
		_bottomBackgroundView.backgroundColor = UIColor.blackColor;
		
		[self addSubview:_bottomBackgroundView];
		
		_pageControlView = [SGPageControlView.alloc initWithFrame:CGRectZero];
		[self addSubview:_pageControlView];
		
		_articleView = [UIView.alloc init];
		_articleView.backgroundColor = UIColor.greenColor;
		[self addSubview:_articleView];
	}
	return self;
}

#pragma mark View loading
- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_navigationView.frame = CGRectMake(0, 0, size.width, 44);
	_backgroundView.frame = CGRectMake(0, 44, size.width, size.height - 44);
	_bottomBackgroundView.frame = CGRectMake(0, size.height, size.width, 8);
	_pageControlView.frame = CGRectMake(0, size.height - 20, size.width, 20);
	
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

- (void)animateDown
{
	[UIView animateWithDuration:0.5 animations:^{
		
		_backgroundView.frame = CGRectOffset(_backgroundView.frame, 8, 8);
		_pageControlView.frame = CGRectOffset(_pageControlView.frame, 8, -8);
		_pageControllerView.frame = CGRectOffset(_pageControllerView.frame, 8, 6);
		_bottomBackgroundView.frame = CGRectOffset(_bottomBackgroundView.frame, 8, -8);
		
		_articleView.frame = CGRectOffset(_articleView.frame, - 320, 0);
		
	} completion:^(BOOL finished){
		
	}];
}

@end
