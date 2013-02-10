//
//  SGArticleViewController.m
//  ufo
//
//  Created by SandGro on 10-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleViewController.h"

@interface SGArticleViewController ()

@end

@implementation SGArticleViewController

@dynamic view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
	self.view = SGArticleView.alloc.init;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
