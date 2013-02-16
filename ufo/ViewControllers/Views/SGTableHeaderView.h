//
//  SGTableHeaderView.h
//  ufo
//
//  Created by SandGro on 16-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGTableHeaderView : UIView
{
@private
	UILabel * _titleLabel;
	UIImageView * _backgroundView;
}

@property (nonatomic, readonly, strong) UILabel * titleLabel;
@property (nonatomic, readonly, strong) UIImageView * backgroundView;

@end
