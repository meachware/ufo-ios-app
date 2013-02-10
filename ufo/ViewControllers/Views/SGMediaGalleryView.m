//
//  SGMediaGalleryView.m
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMediaGalleryView.h"
#import "SGImageGallery.h"
#import "SGImageHeaders.h"

@implementation SGMediaGalleryView

@synthesize pagingScrollView = _pagingScrollView;
@synthesize pageControl = _pageControl;
@synthesize captionLabel = _captionLabel;
@synthesize layout = _layout;
@synthesize mediaViews = _mediaViews;
@synthesize imageGallery = _imageGallery;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = UIColor.greenColor;
		
		_mediaViews = NSMutableArray.alloc.init;
		
		_layout = kSGMediaGalleryViewLayoutHalf;
		
		_pagingScrollView = [SGPagingScrollView.alloc initWithFrame:CGRectZero
														   pageSize:CGSizeMake(320, 100)
															spacing:0
														   delegate:self];
		[self addSubview:_pagingScrollView];
		
		_captionLabel = UILabel.alloc.init;
		_captionLabel.textColor = UIColor.blackColor;
		_captionLabel.text = @"Caption text";
		[self addSubview:_captionLabel];
		
		_pageControl = UIPageControl.alloc.init;
		_pageControl.pageIndicatorTintColor = UIColor.greenColor;
		[self addSubview:_pageControl];
    }
    return self;
}

- (void)setImageGallery:(SGImageGallery *)imageGallery
{
	_imageGallery = imageGallery;
	
		[_imageGallery.images enumerateObjectsUsingBlock:^(SGImage * obj, BOOL * stop){
			
			SGImageData * imageData = [SGImageData.alloc initWithPath:obj.location type:SGImageType.detailImageType];
			SGImageView * imageView = [SGImageView.alloc initWithImageData:imageData];
			
			[_mediaViews addObject:imageView];
			
		}];
		
	[_pagingScrollView reload];
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
	_pageControl.frame = CGRectMake(100, CGRectGetMaxY(_captionLabel.frame), size.width, 20);
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
