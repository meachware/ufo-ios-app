//
//  SGPageModelController.m
//  ufo
//
//  Created by SandGro on 13-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGPageModelController.h"
#import "SGTableViewController.h"

@implementation SGPageModelController

@synthesize dataViewControllers = _dataViewControllers;

#pragma mark Initialization

- (id)init
{
	self = [super init];
	if (self)
	{
		SGTableViewController * newsTableViewController = [SGTableViewController.alloc init];
		SGTableViewController * reportTableViewController = [SGTableViewController.alloc init];
		SGTableViewController * videoTableViewController = [SGTableViewController.alloc init];
		
		_dataViewControllers = [NSArray arrayWithObjects:newsTableViewController, reportTableViewController, videoTableViewController, nil];
	}
	return self;
}

#pragma mark Public Methods
- (SGTableViewController *)viewControllerAtIndex:(NSUInteger)index
{
	return [_dataViewControllers objectAtIndex:index];
}

- (NSUInteger)indexOfViewController:(SGTableViewController *)viewController
{
	return [_dataViewControllers indexOfObject:viewController];
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:(SGTableViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:(SGTableViewController *)viewController];
    if (index == NSNotFound)
	{
        return nil;
    }
    
    index++;
    if (index == _dataViewControllers.count)
	{
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
