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
@class SGArticleViewController;

@interface SGMainViewController : UIViewController <UIPageViewControllerDelegate>
{
@private
	UIToolbar * _toolbar;
	UIPageViewController * _pageViewController;
	SGPageModelController * _pageModelController;
	SGTableViewController * _currentViewController;
	SGArticleViewController * _articleViewController;
}

#pragma mark Properties
@property (nonatomic, strong) SGMainControllerView * view;
@property (nonatomic, strong, readonly) UIPageViewController * pageViewController;
@property (nonatomic, strong, readonly) SGPageModelController * pageModelController;
@property (nonatomic, strong, readonly) SGArticleViewController * articleViewController;

@end
