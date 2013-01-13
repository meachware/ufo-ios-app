//
//  SGMainViewController.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGPageModelController.h"

@interface SGMainViewController ()

@end

@implementation SGMainViewController

#pragma mark Properties

@dynamic view;
@synthesize pageViewController = _pageViewController;
@synthesize pageModelController = _pageModelController;

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
        _navigationController = UINavigationController.alloc.init;
		[self addChildViewController:_navigationController];
		
		_pageViewController = [UIPageViewController.alloc initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
		
		_pageModelController = SGPageModelController.alloc.init;
		
		_pageViewController.dataSource = _pageModelController;
		_pageViewController.delegate = self;
    }
    return self;
}

#pragma mark View Loading

- (void)loadView
{
	self.view = [SGMainControllerView.alloc initWithNavigationView:_navigationController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_bg"] forBarMetrics:UIBarMetricsDefault];
	
	SGTableViewController * startingViewController = [_pageModelController viewControllerAtIndex:0];
	NSArray * viewControllers = @[startingViewController];
	
	[_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	[self addChildViewController:_pageViewController];
	[self.view addPageControllerView:_pageViewController.view];
	
	[_pageViewController didMoveToParentViewController:self];
	
	self.view.gestureRecognizers = _pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
