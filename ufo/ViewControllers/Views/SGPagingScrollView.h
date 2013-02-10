//
//  VMPagingScrollView.h
//  tvgidsios
//
//  Created by Sander Grout on 22-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

@class SGPagingScrollView;

@protocol SGPagingScrollViewDelegate <NSObject>
@required

#pragma mark Delegation methods
- (UIView *)pageScrollView:(SGPagingScrollView *)pageScrollView viewForPageAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfPagesInPageScrollView:(SGPagingScrollView *)scrollView;

@optional

#pragma mark Optional delegation methods
- (void)pageScrollView:(SGPagingScrollView *)pageScrollView didScrollToPageIndex:(NSUInteger)index;

@end

#pragma mark -

@interface SGPagingScrollView : UIView <UIScrollViewDelegate>
{
@private
	UIScrollView * _scrollView;
	NSMutableArray * _scrollViewPages;
	CGSize _pageSize;
	__weak id<SGPagingScrollViewDelegate> _delegate;
	
	NSInteger _pageCount;
	CGFloat _spacing;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) UIScrollView * scrollView;
@property (nonatomic, weak, readonly) NSArray * pages;
@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign, readonly) CGSize pageSize;
@property (nonatomic, weak) id<SGPagingScrollViewDelegate> delegate;

#pragma mark Initialization
- (id)initWithFrame:(CGRect)frame pageSize:(CGSize)pageSize spacing:(CGFloat)spacing delegate:(id<SGPagingScrollViewDelegate>)delegate;

#pragma mark Public methods
- (void)reload;
- (void)reloadWithPageIndex:(NSUInteger)pageIndex;
- (void)reloadWithPageIndex:(NSUInteger)pageIndex pageSize:(CGSize)pageSize spacing:(CGFloat)spacing;
- (void)removeUnusedPages;

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex animated:(BOOL)animated;

@end
