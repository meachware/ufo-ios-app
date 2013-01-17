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

@interface SGTableViewController : UITableViewController
{
@private
	SelectArticleProvider _selectArticleProvider;
	NSArray * _articles;
}

@property (nonatomic, copy) SelectArticleProvider selectArticleProvider;
@property (nonatomic, readonly, strong) NSArray * articles;

@end
