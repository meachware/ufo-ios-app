//
//  SGMediaGalleryView.h
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPagingScrollView.h"

typedef enum
{
	kSGMediaGalleryViewLayoutHalf = 0,
	kSGMediaGalleryViewLayoutFull
} SGMediaGalleryViewLayout;

@interface SGMediaGalleryView : UIView <SGPagingScrollViewDelegate>
{
@private
	SGPagingScrollView * _pagingScrollView;
	UIPageControl * _pageControl;
	UILabel * _captionLabel;
	UIView * _mediaDataIcons;
	SGMediaGalleryViewLayout _layout;
	NSArray * _mediaViews;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGPagingScrollView * pagingScrollView;
@property (nonatomic, readonly, strong) UIPageControl * pageControl;
@property (nonatomic, readonly, strong) UILabel * captionLabel;
@property SGMediaGalleryViewLayout layout;
@property (nonatomic, readonly, strong) NSArray * mediaViews;

#pragma mark Initializer
- (id)initWithFrame:(CGRect)frame mediaViews:(NSArray *)mediaViews;

@end
