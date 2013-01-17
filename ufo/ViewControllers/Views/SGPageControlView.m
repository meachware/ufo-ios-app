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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        self.backgroundColor = [UIColor grayColor];
		
		_pageControl = [UIPageControl.alloc init];
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
}



@end
