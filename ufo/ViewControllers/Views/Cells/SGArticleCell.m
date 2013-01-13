//
//  SGArticleCell.m
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import "SGArticleCell.h"

@implementation SGArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		UIImage * backgroundImage = [UIImage imageNamed:@"cell_background_gray"];
		UIImageView * backgroundView = [UIImageView.alloc initWithImage:[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)]];
		self.backgroundView = backgroundView;
		
		self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
	[super layoutSubviews];
}




@end
