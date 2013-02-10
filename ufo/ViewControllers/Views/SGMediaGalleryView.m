//
//  SGMediaGalleryView.m
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMediaGalleryView.h"

@implementation SGMediaGalleryView

@synthesize pagingScrollView = _pagingScrollView;
@synthesize pageControl = _pageControl;
@synthesize captionLabel = _captionLabel;
@synthesize layout = _layout;
@synthesize mediaViews = _mediaViews;

- (id)initWithFrame:(CGRect)frame mediaViews:(NSArray *)mediaViews
{
    self = [super initWithFrame:frame];
    if (self)
	{
		_mediaViews = mediaViews;
		
		_layout = kSGMediaGalleryViewLayoutHalf;
		
		_pagingScrollView = [SGPagingScrollView.alloc initWithFrame:CGRectZero
														   pageSize:CGSizeMake(self.bounds.size.width, 200)
															spacing:0
														   delegate:self];
		[self addSubview:_pagingScrollView];
		
		_captionLabel = UILabel.alloc.init;
		[self addSubview:_captionLabel];
		
		_pageControl = UIPageControl.alloc.init;
		_pageControl.pageIndicatorTintColor = UIColor.greenColor;
		[self addSubview:_pageControl];
    }
    return self;
}

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	if (_layout == kSGMediaGalleryViewLayoutHalf)
	{
		_pagingScrollView.frame = CGRectMake(0, 0, size.width, 100);
	}
	else if (_layout == kSGMediaGalleryViewLayoutFull)
	{
		_pagingScrollView.frame = CGRectMake(0, 0, size.width, 200);
	}
	_captionLabel.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame), size.width, 20);
	_pageControl.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame), size.width, 20);
}

#pragma mark Paging ScrollView Delegation methods
- (UIView *)pageScrollView:(SGPagingScrollView *)pageScrollView viewForPageAtIndex:(NSUInteger)index
{
	return [_mediaViews objectAtIndex:index];
}


- (NSUInteger)numberOfPagesInPageScrollView:(SGPagingScrollView *)scrollView
{
	return _mediaViews.count;
}

- (void)pageScrollView:(SGPagingScrollView *)pageScrollView didScrollToPageIndex:(NSUInteger)index
{
	_pageControl.currentPage = index;
}

@end
