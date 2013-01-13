//
//  SGPageModelController.h
//  ufo
//
//  Created by SandGro on 13-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGTableViewController;

@interface SGPageModelController : NSObject <UIPageViewControllerDataSource>
{
@private
	NSArray * _dataViewControllers;
}

#pragma mark Properties
@property (nonatomic, strong, readonly) NSArray * dataViewControllers;

#pragma mark Public Methods
- (SGTableViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(SGTableViewController *)viewController;

@end
