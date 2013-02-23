//
//  SGBarButton.m
//  ufo
//
//  Created by SandGro on 23-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGBarButton.h"

@interface SGBarButton ()
- (void)doButtonTapped:(id)sender;
@end

@implementation SGBarButton

#pragma mark Properties

@synthesize upInside = _upInside;

@synthesize type = _type;

- (id)initWithType:(SGBarButtonType)type
{
	CGRect frame = CGRectMake(0, 0, 64, 31);
	if (type == kSharingType)
		frame = CGRectMake(0, 0, 40, 31);
	
    self = [super initWithFrame:frame];
    if (self)
	{
		_type = type;
		
		if (type == kBackButtonType)
		{
			[self setBackgroundImage:[UIImage imageNamed:@"barbutton_back"] forState:UIControlStateNormal];
			[self setBackgroundImage:[UIImage imageNamed:@"barbutton_back_highlighted"] forState:UIControlStateHighlighted];
			
			self.titleLabel.font = [UIFont boldSystemFontOfSize:UIFont.smallSystemFontSize];
			self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
			
			[self setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
		}
		else if (type == kSharingType)
		{
			[self setBackgroundImage:[UIImage imageNamed:@"barbutton_share"] forState:UIControlStateNormal];
			[self setBackgroundImage:[UIImage imageNamed:@"barbutton_share_highlighted"] forState:UIControlStateHighlighted];
		}
		
		[self addTarget:self action:@selector(doButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)doButtonTapped:(id)sender
{
	if (_upInside)
	{
		_upInside();
	}
}

@end
