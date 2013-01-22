//
//  SGTableViewController.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGTableViewController.h"
#import "SGArticleCell.h"
#import "SGBaseArticle.h"
#import "SGRequestManager.h"
#import "SGArticleRequest.h"

@interface SGTableViewController ()
- (void)loadData;
@end

@implementation SGTableViewController

@synthesize selectArticleProvider = _selectArticleProvider;
@synthesize articles = _articles;

- (id)init
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self)
	{
        [self.tableView registerClass:SGArticleCell.class forCellReuseIdentifier:@"Cell"];
		
		self.refreshControl = [UIRefreshControl.alloc init];
		self.refreshControl.attributedTitle = [NSAttributedString.alloc initWithString:@"Pull to refresh"];
		[self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.backgroundColor = nil;
	self.tableView.backgroundView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	SGBaseArticle * article = [_articles objectAtIndex:indexPath.row];
	
	cell.textLabel.text = article.title;
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectArticleProvider)
	{
		_selectArticleProvider(SGBaseArticle.alloc.init);
	}
}

#pragma mark Actions

- (void)refresh:(id)sender
{
	self.refreshControl.attributedTitle = [NSAttributedString.alloc initWithString:@"Refreshing"];
	
	[self loadData];
}

#pragma mark Private

- (void)loadData
{
	[SGRequestManager.shared loadRequestInArticleQueue:SGArticleRequest.alloc.initNewsArticles prioritized:NO];
}

@end
