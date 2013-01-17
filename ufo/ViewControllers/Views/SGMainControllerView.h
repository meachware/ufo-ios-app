//
//  SGMainControllerView.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPageControlView.h"

@interface SGMainControllerView : UIView
{
@private
	UIView * _navigationView;
	UIView * _backgroundView;
	UIView * _bottomBackgroundView;
	UIView * _pageControllerView;
	UIView * _articleView;
	SGPageControlView * _pageControlView;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) UIView * navigationView;
@property (nonatomic, strong, readonly) UIView * backgroundView;
@property (nonatomic, strong, readonly) UIView * bottomBackgroundView;
@property (nonatomic, strong, readonly) UIView * pageControllerView;
@property (nonatomic, strong, readonly) UIView * articleView;
@property (nonatomic, strong, readonly) SGPageControlView * pageControlView;

#pragma mark Initialization
- (id)initWithNavigationView:(UIView *)navigationView;

#pragma mark Public Methods
- (void)addPageControllerView:(UIView *)pageControllerView;
- (void)animateDown;
@end
