//
//  SGMainControllerView.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMainControllerView.h"

@implementation SGMainControllerView

#pragma mark Properties

@synthesize navigationView = _navigationView;
@synthesize backgroundView = _backgroundView;
@synthesize pageControllerView = _pageControllerView;

#pragma mark Initialization

- (id)initWithNavigationView:(UIView *)navigationView
{
	self = [super init];
	if (self)
	{
		_navigationView = navigationView;
		
		
		_backgroundView = UIView.alloc.init;
		_backgroundView.backgroundColor = [UIColor grayColor];
		
		[self addSubview:_backgroundView];
		
		[_backgroundView addSubview:_navigationView];
	}
	return self;
}

#pragma mark View loading
- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_backgroundView.frame = CGRectMake(0, 0, size.width, size.height);
	_navigationView.frame = CGRectMake(0, 0, size.width, 48);
	
	if (_pageControllerView)
	{
		_pageControllerView.frame = CGRectMake(0, 48, size.width, size.height - 48);
	}
}

#pragma mark Public Methods

- (void)addPageControllerView:(UIView *)pageControllerView
{
	if (!_pageControllerView)
	{
		_pageControllerView = pageControllerView;
		[self addSubview:_pageControllerView];
		
		[self setNeedsLayout];
	}
}

@end
