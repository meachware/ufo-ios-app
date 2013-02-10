//
//  VMPagingScrollView.m
//  tvgidsios
//
//  Created by Sander Grout on 22-11-12.
//  Copyright (c) 2012 Veronica Magazine. All rights reserved.
//

#import "SGPagingScrollView.h"
#import <QuartzCore/QuartzCore.h>


@interface SGPagingScrollView ()

#pragma mark Private methods
- (void)initPagesAroundIndex:(NSUInteger)pageIndex;
- (void)loadPageWithIndex:(NSUInteger)pageIndex;

@end


#pragma mark -


@implementation SGPagingScrollView

#pragma mark Properties

@synthesize scrollView = _scrollView;
@synthesize pageSize = _pageSize;
@synthesize delegate = _delegate;

#pragma mark Initiliazation

- (id)initWithFrame:(CGRect)frame pageSize:(CGSize)pageSize spacing:(CGFloat)spacing delegate:(id<SGPagingScrollViewDelegate>)delegate
{
	self = [super initWithFrame:frame];
	if (self)
	{
		_pageSize = pageSize;
		_spacing = spacing;
		_delegate = delegate;
		
		_scrollView = [UIScrollView.alloc initWithFrame:CGRectZero];
		_scrollView.clipsToBounds = NO;
		_scrollView.pagingEnabled = YES;
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.delegate = self;
		[self addSubview:_scrollView];
		
		_scrollViewPages = nil;
		
		//[self reload];
	}
	return self;
}

#pragma mark Public methods

- (void)reload
{
	[self reloadWithPageIndex:0];
}

- (void)reloadWithPageIndex:(NSUInteger)pageIndex
{
	[self reloadWithPageIndex:pageIndex pageSize:_pageSize spacing:_spacing];
}

- (void)reloadWithPageIndex:(NSUInteger)pageIndex pageSize:(CGSize)pageSize spacing:(CGFloat)spacing
{
	_pageSize = pageSize;
	_spacing = spacing;
	
	if (_scrollViewPages)
	{
		for (UIView * view in _scrollViewPages)
		{
			if ([view isKindOfClass:UIView.class])
			{
				[view removeFromSuperview];
			}
		}
		[_scrollViewPages removeAllObjects];
	}
	
	_pageCount = [_delegate numberOfPagesInPageScrollView:self];
	_scrollViewPages = [NSMutableArray.alloc initWithCapacity:_pageCount];
	
	for (int i = 0; i < _pageCount; i++)
	{
		[_scrollViewPages addObject:NSNull.null];
	}
	
	_scrollView.contentSize = CGSizeMake(_pageCount * (_pageSize.width + _spacing), _pageSize.height);
	
	[self setCurrentPageIndex:pageIndex animated:NO];
	
	[self setNeedsLayout];
}

- (void)removeUnusedPages
{
	NSUInteger currentPageIndex = self.currentPageIndex;
	
	for (NSUInteger index = 0; index < _scrollViewPages.count; index++)
	{
		UIView * view = [_scrollViewPages objectAtIndex:index];
		if ([view isKindOfClass:UIView.class])
		{
			if (index < currentPageIndex - 1 || index > currentPageIndex + 1)
			{
				[view removeFromSuperview];
				[_scrollViewPages replaceObjectAtIndex:index withObject:NSNull.null];
			}
		}
	}
}

- (void)setCurrentPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
	CGFloat offset = pageIndex * (_pageSize.width + _spacing);
	
	[_scrollView setContentOffset:CGPointMake(offset, 0) animated:animated];
	
	[self initPagesAroundIndex:pageIndex];
}

#pragma mark Overridden methods

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_scrollView.frame = CGRectMake(roundf((size.width - _pageSize.width) / 2),
								   roundf((size.height - _pageSize.height) / 2),
								   _pageSize.width + _spacing,
								   _pageSize.height);
}

#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self initPagesAroundIndex:self.currentPageIndex];
}

#pragma mark Private methods

- (void)initPagesAroundIndex:(NSUInteger)pageIndex
{
	[self loadPageWithIndex:pageIndex];
	
	if (pageIndex > 0)
	{
		[self loadPageWithIndex:pageIndex - 1];
	}
	
	if (pageIndex < _pageCount - 1)
	{
		[self loadPageWithIndex:pageIndex + 1];
	}
	
	if (_delegate && [_delegate respondsToSelector:@selector(pageScrollView:didScrollToPageIndex:)])
	{
		[_delegate pageScrollView:self didScrollToPageIndex:pageIndex];
	}
}

- (void)loadPageWithIndex:(NSUInteger)pageIndex
{
    if (pageIndex < _scrollViewPages.count)
	{
		UIView * view = [_scrollViewPages objectAtIndex:pageIndex];
		
		if (![view isKindOfClass:UIView.class])
		{
			view = [_delegate pageScrollView:self viewForPageAtIndex:pageIndex];
			[_scrollViewPages replaceObjectAtIndex:pageIndex withObject:view];
		}
		
		if (view.superview == nil)
		{
			CGSize viewSize = view.bounds.size;
			view.frame = CGRectMake((_pageSize.width + _spacing) * pageIndex + roundf((_pageSize.width - viewSize.width) / 2),
									roundf((_pageSize.height - viewSize.height) / 2),
									viewSize.width,
									viewSize.height);
			
			[_scrollView addSubview:view];
		}
	}
}

#pragma mark Property implementtions

- (NSArray *)pages
{
	return _scrollViewPages.copy;
}

- (NSUInteger)currentPageIndex
{
	return roundf((_scrollView.contentOffset.x / (_pageSize.width + _spacing)));
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
	[self setCurrentPageIndex:currentPageIndex animated:YES];
}

@end
