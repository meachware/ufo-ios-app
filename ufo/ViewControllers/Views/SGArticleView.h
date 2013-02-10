//
//  SGArticleView.h
//  ufo
//
//  Created by SandGro on 05-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGBaseArticle;

@interface SGArticleView : UIView
{
@private
	SGBaseArticle * _article;
	UILabel * _paragraphTextLabel;
}

#pragma mark Properties
@property (nonatomic, readwrite, strong) SGBaseArticle * article;
@property (nonatomic, readonly, strong) UILabel * paragraphTextLabel;

@end
