//
//  SGTableHeaderView.m
//  ufo
//
//  Created by SandGro on 16-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGTableHeaderView.h"

@implementation SGTableHeaderView

@synthesize titleLabel = _titleLabel;
@synthesize backgroundView = _backgroundView;

- (id)init
{
    self = [super init];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		
		UIImage * backgroundImage = [UIImage imageNamed:@"cell_header_background_gray"];
		_backgroundView = [UIImageView.alloc initWithImage:backgroundImage];
		
		[self addSubview:_backgroundView];
		
		_titleLabel = UILabel.alloc.init;
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.numberOfLines = 1;
		_titleLabel.backgroundColor = [UIColor clearColor];
		
		[self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	
	_titleLabel.frame = CGRectMake(0, (size.height - 25) /2, size.width, 30);
	_backgroundView.frame = CGRectMake(9, 4, size.width - 18, size.height - 4);
}

@end
