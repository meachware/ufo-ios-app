//
//  SGPageControlView.h
//  ufo
//
//  Created by SandGro on 13-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGPageControlView : UIView
{
@private
	UIPageControl * _pageControl;
	UIImageView * _backgroundView;
}

@property (nonatomic, strong, readonly) UIPageControl * pageControl;
@property (nonatomic, strong, readonly) UIImageView * backgroundView;

@end
