//
//  SGPageControlView.m
//  ufo
//
//  Created by SandGro on 13-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGPageControlView.h"

@implementation SGPageControlView

@synthesize pageControl = _pageControl;
@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        UIImage * backgroundImage = [UIImage imageNamed:@"pagecontrol_background"];
		UIImageView * backgroundView = [UIImageView.alloc initWithImage:[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)]];
		_backgroundView = backgroundView;
		
		[self addSubview:_backgroundView];
		
		_pageControl = [UIPageControl.alloc init];
		_pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
		_pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
		[self addSubview:_pageControl];
    }
    return self;
}

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_pageControl.frame = CGRectMake(roundf((size.width - _pageControl.bounds.size.width) /2),
									roundf((size.height - _pageControl.bounds.size.height) /2),
									_pageControl.bounds.size.width,
									_pageControl.frame.size.height);
	
	_backgroundView.frame = self.bounds;
}



@end
