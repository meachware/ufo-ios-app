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

@interface SGMediaGalleryView ()
- (void)handleTab;
@end

@implementation SGMediaGalleryView

@synthesize pagingScrollView = _pagingScrollView;
@synthesize pageControl = _pageControl;
@synthesize captionLabel = _captionLabel;
@synthesize mediaViews = _mediaViews;
@synthesize imageType = _imageType;
@synthesize imageGallery = _imageGallery;
@synthesize shadowTop = _shadowTop;
@synthesize shadowBottom = _shadowBottom;
@synthesize checkerOverlay = _checkerOverlay;
@synthesize delegate = _delegate;

- (id)initWithImageType:(SGImageType *)imageType
{
	self = [super initWithFrame:CGRectMake(0, 0, imageType.size.width, imageType.size.height)];
	if (self)
	{
		_imageType = imageType;
		
		self.backgroundColor = UIColor.whiteColor;
		
		_mediaViews = NSMutableArray.alloc.init;
				
		_pagingScrollView = [SGPagingScrollView.alloc initWithFrame:CGRectZero
														   pageSize:CGSizeMake(320, imageType.size.height)
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
		
		_shadowTop = [UIImageView.alloc initWithImage:[UIImage imageNamed:@"shadow_top"]];
		[self insertSubview:_shadowTop aboveSubview:_pagingScrollView];
		
		_shadowBottom = [UIImageView.alloc initWithImage:[UIImage imageNamed:@"shadow_bottom"]];
		[self insertSubview:_shadowBottom aboveSubview:_pagingScrollView];
		
		UITapGestureRecognizer * tabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTab)];
		[tabRecognizer setNumberOfTouchesRequired:1];
		[self addGestureRecognizer:tabRecognizer];
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
			
			SGImageData * imageData = [SGImageData.alloc initWithPath:obj.location type:SGImageType.galleryImageLargeType];
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
	
	_pagingScrollView.frame = CGRectMake(0, 0, size.width, SGImageType.galleryImageLargeType.size.height);
	_checkerOverlay.frame = _pagingScrollView.frame;
	
	//_captionLabel.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame), size.width, 20);
	_pageControl.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame) + 2, size.width, 10);
	
	_shadowTop.frame = CGRectMake(0, _pagingScrollView.frame.origin.y, _pagingScrollView.frame.size.width, 4);
	_shadowBottom.frame = CGRectMake(0, CGRectGetMaxY(_pagingScrollView.frame) - 4, _pagingScrollView.frame.size.width, 4);
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

#pragma mark Private Methods

- (void)handleTab
{
	[_delegate mediaGalleryViewTabbed:self];
}

@end
