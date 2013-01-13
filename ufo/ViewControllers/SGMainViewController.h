//
//  SGMainViewController.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGMainControllerView.h"
#import "SGTableViewController.h"

@class SGPageModelController;

@interface SGMainViewController : UIViewController <UIPageViewControllerDelegate>
{
@private
	UINavigationController * _navigationController;
	UIPageViewController * _pageViewController;
	SGPageModelController * _pageModelController;
}

#pragma mark Properties
@property (nonatomic, strong) SGMainControllerView * view;
@property (nonatomic, strong, readonly) UIPageViewController * pageViewController;
@property (nonatomic, strong, readonly) SGPageModelController * pageModelController;

@end
