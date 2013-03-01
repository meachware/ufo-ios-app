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
														   pageSize:CGSizeMake(320, SGImageType.galleryImageSmallType.size.height)
															spacing:0
														   delegate:self];
		[self addSubview:_pagingScrollView];
		
		_captionLabel = UILabel.alloc.init;
		_captionLabel.textColor = UIColor.whiteColor;
		_captionLabel.backgroundColor = UIColor.blackColor;
		//[self addSubview:_captionLabel];
		
		_pageControl = UIPageControl.alloc.init;
		_pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
		_pageControl.backgroundColor = UIColor.whiteColor;
		_pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor;
		_pageControl.hidesForSinglePage = YES;
		[self addSubview:_pageControl];
    }
    return self;
}

- (void)setImageGallery:(SGImageGallery *)imageGallery
{
	if (_imageGallery != imageGallery)
	{
		_imageGallery = imageGallery;
		
		[_mediaViews removeAllObjects];
		
		[_imageGallery.images enumerateObjectsUsingBlock:^(SGImage * obj, BOOL * stop){
			
			SGImageData * imageData = [SGImageData.alloc initWithPath:obj.location type:SGImageType.galleryImageSmallType];
			SGImageView * imageView = [SGImageView.alloc initWithImageData:imageData];
			
			[_mediaViews addObject:imageView];
		}];
		
		_pageControl.numberOfPages = _mediaViews.count;
		
		[_pagingScrollView reload];
	}
}

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	if (_layout == kSGMediaGalleryViewLayoutHalf)
	{
		CGSize imageSize = SGImageType.galleryImageSmallType.size;
		
		_pagingScrollView.frame = CGRectMake(0, 0, size.width, imageSize.height);
	}
	else if (_layout == kSGMediaGalleryViewLayoutFull)
	{
		CGSize imageSize = SGImageType.galleryImageLargeType.size;
		
		_pagingScrollView.frame = CGRectMake(0, 0, size.width, imageSize.height);
	}
	
	_captionLabel.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame), size.width, 20);
	_pageControl.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame) + 2, size.width, 10);
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
