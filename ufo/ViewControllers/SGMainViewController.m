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
	[_navigationController didMoveToParentViewController:self];
	
	SGTableViewController * startingViewController = [_pageModelController viewControllerAtIndex:0];
	NSArray * viewControllers = @[startingViewController];
	
	[_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	[self addChildViewController:_pageViewController];
	[self.view addPageControllerView:_pageViewController.view];
	
	[_pageViewController didMoveToParentViewController:self];
	
	self.view.gestureRecognizers = _pageViewController.gestureRecognizers;
	
	self.view.pageControlView.pageControl.numberOfPages = _pageModelController.dataViewControllers.count;
	self.view.pageControlView.pageControl.currentPage = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UIPageViewController Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
	if (completed)
	{
		NSUInteger index = [_pageModelController indexOfViewController:_currentViewController];
		if (index != NSNotFound)
		{
			self.view.pageControlView.pageControl.currentPage = index;
		}
	}
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
	if (pendingViewControllers.count == 1)
	{
		__weak SGMainViewController * me = self;
		
		_currentViewController = [pendingViewControllers objectAtIndex:0];
		[_currentViewController setSelectArticleProvider:^(SGBaseArticle * article){
			
			
			[me.view animateDown];
		}];
	}
}

@end
