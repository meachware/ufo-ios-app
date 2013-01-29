//
//  SGTableViewController.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGBaseArticle;

typedef void (^SelectArticleProvider)(SGBaseArticle * article);

@interface SGTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
@private
	SelectArticleProvider _selectArticleProvider;
	NSManagedObjectContext * _managedObjectContext;
	NSFetchedResultsController * _fetchedResultsController;
}

@property (nonatomic, copy) SelectArticleProvider selectArticleProvider;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController * fetchedResultsController;


@end
