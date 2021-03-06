//
//  SGTableViewController.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGTableViewController.h"
#import "SGArticleCell.h"
#import "SGTableHeaderView.h"
#import "SGBaseArticle.h"
#import "SGRequestManager.h"
#import "SGArticleRequest.h"
#import "SGDataManager.h"

@interface SGTableViewController ()
- (void)loadData;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation SGTableViewController

@synthesize selectArticleProvider = _selectArticleProvider;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)init
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self)
	{
        [self.tableView registerClass:SGArticleCell.class forCellReuseIdentifier:@"Cell"];
		self.tableView.backgroundView = nil;
		self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table_background"]];
		
		NSMutableAttributedString * refreshTitle = [NSMutableAttributedString.alloc initWithString:@"Pull to refresh"];
		[refreshTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:12.0f] range:NSMakeRange(0, refreshTitle.length)];
		[refreshTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, refreshTitle.length)];
		
		self.refreshControl = [UIRefreshControl.alloc init];
		self.refreshControl.attributedTitle = refreshTitle;
		self.refreshControl.tintColor = [UIColor darkGrayColor];
		
		[self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
		
		[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(updateData) name:kSGNewsArticlesChanged object:nil];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_managedObjectContext = [SGDataManager.shared managedObjectContext];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error])
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{	
    if (_fetchedResultsController != nil)
	{
        return _fetchedResultsController;
    }
	
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"SGNewsArticle" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"publishDate" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController * theFetchedResultsController =
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
										managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
												   cacheName:@"cache"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
	
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{	
    UITableView * tableView = self.tableView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
			
        case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
	return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	[self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectArticleProvider)
	{
		SGBaseArticle * article = [_fetchedResultsController objectAtIndexPath:indexPath];
		
		_selectArticleProvider(article);
	}
}

- (void)configureCell:(SGArticleCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    SGBaseArticle * article = [_fetchedResultsController objectAtIndexPath:indexPath];
    
	cell.article = article;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	SGTableHeaderView * headerView = [SGTableHeaderView.alloc init];
	headerView.titleLabel.text = @"News";
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

#pragma mark Actions

- (void)refresh:(id)sender
{
	NSMutableAttributedString * refreshTitle = [NSMutableAttributedString.alloc initWithString:@"Refreshing"];
	[refreshTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:12.0f] range:NSMakeRange(0, refreshTitle.length)];
	[refreshTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, refreshTitle.length)];
	
	self.refreshControl.attributedTitle = refreshTitle;
	
	[self loadData];
}

#pragma mark Private

- (void)loadData
{
	[SGRequestManager.shared loadRequestInArticleQueue:SGArticleRequest.alloc.initNewsArticles prioritized:NO];
}

- (void)updateData
{
	NSError * error;
	if (![[self fetchedResultsController] performFetch:&error])
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	[self.refreshControl endRefreshing];
	
	NSMutableAttributedString * refreshTitle = [NSMutableAttributedString.alloc initWithString:@"Pull To Refresh"];
	[refreshTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:12.0f] range:NSMakeRange(0, refreshTitle.length)];
	[refreshTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, refreshTitle.length)];
	
	self.refreshControl.attributedTitle = refreshTitle;
}

@end
