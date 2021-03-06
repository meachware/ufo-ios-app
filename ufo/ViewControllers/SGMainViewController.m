//
//  SGMainViewController.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGPageModelController.h"
#import "SGArticleViewController.h"

@interface SGMainViewController ()

@end

@implementation SGMainViewController

#pragma mark Properties

@dynamic view;
@synthesize pageViewController = _pageViewController;
@synthesize pageModelController = _pageModelController;
@synthesize articleViewController = _articleViewController;

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
        _toolbar = [UIToolbar.alloc init];
		
		_pageViewController = [UIPageViewController.alloc initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
		
		_pageModelController = SGPageModelController.alloc.init;
		
		_pageViewController.dataSource = _pageModelController;
		_pageViewController.delegate = self;
		
		_articleViewController = SGArticleViewController.alloc.init;
    }
    return self;
}

#pragma mark View Loading

- (void)loadView
{
	self.view = [SGMainControllerView.alloc initWithToolBar:_toolbar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[_toolbar setBackgroundImage:[UIImage imageNamed:@"topbar_background"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
	
	SGTableViewController * startingViewController = [_pageModelController viewControllerAtIndex:0];
	
	__weak SGMainViewController * me = self;
	[startingViewController setSelectArticleProvider:^(SGBaseArticle * article){
		[me.view presentArticle:article];
	}];
	
	NSArray * viewControllers = @[startingViewController];
	
	[_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	[self addChildViewController:_pageViewController];
	[self.view addPageControllerView:_pageViewController.view];
	
	[_pageViewController didMoveToParentViewController:self];
	
	self.view.gestureRecognizers = _pageViewController.gestureRecognizers;
	
	self.view.pageControlView.pageControl.numberOfPages = _pageModelController.dataViewControllers.count;
	self.view.pageControlView.pageControl.currentPage = 0;
	
	self.view.articleView = _articleViewController.view;
	[self addChildViewController:_articleViewController];
	[_articleViewController didMoveToParentViewController:self];
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
			
			[me.view presentArticle:article];
			
		}];
	}
}

- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}

@end
