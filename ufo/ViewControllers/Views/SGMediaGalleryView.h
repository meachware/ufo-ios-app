//
//  SGMediaGalleryView.h
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPagingScrollView.h"

@class SGImageGallery;
@class SGMediaGalleryView;
@class SGImageType;

 
@protocol SGMediaGalleryViewDelegate <NSObject>
@required
- (void)mediaGalleryViewTabbed:(SGMediaGalleryView *)view;
@end

@interface SGMediaGalleryView : UIView <SGPagingScrollViewDelegate>
{
@private
	SGPagingScrollView * _pagingScrollView;
	UIPageControl * _pageControl;
	UILabel * _captionLabel;
	UIView * _mediaDataIcons;
	SGImageType * _imageType;
	SGImageGallery * _imageGallery;
	NSMutableArray * _mediaViews;
	UIImageView * _shadowTop;
	UIImageView * _shadowBottom;
	UIImageView * _checkerOverlay;
	__weak id<SGMediaGalleryViewDelegate> _delegate;
}

#pragma mark Properties
@property (nonatomic, readonly, strong) SGPagingScrollView * pagingScrollView;
@property (nonatomic, readonly, strong) UIPageControl * pageControl;
@property (nonatomic, readonly, strong) UILabel * captionLabel;
@property (nonatomic, readonly, strong) NSMutableArray * mediaViews;
@property (nonatomic, readwrite, strong) SGImageType * imageType;
@property (nonatomic, readwrite, strong) SGImageGallery * imageGallery;
@property (nonatomic, readonly, strong) UIImageView * shadowTop;
@property (nonatomic, readonly, strong) UIImageView * shadowBottom;
@property (nonatomic, readonly, strong) UIImageView * checkerOverlay;
@property (nonatomic, weak) id<SGMediaGalleryViewDelegate> delegate;

#pragma mark Initializer
- (id)initWithImageType:(SGImageType *)imageType;

@end
