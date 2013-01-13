//
//  SGMainControllerView.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGMainControllerView : UIView
{
@private
	UIView * _navigationView;
	UIView * _backgroundView;
	UIView * _pageControllerView;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) UIView * navigationView;
@property (nonatomic, strong, readonly) UIView * backgroundView;
@property (nonatomic, strong, readonly) UIView * pageControllerView;

#pragma mark Initialization
- (id)initWithNavigationView:(UIView *)navigationView;

#pragma mark Public Methods
- (void)addPageControllerView:(UIView *)pageControllerView;

@end
