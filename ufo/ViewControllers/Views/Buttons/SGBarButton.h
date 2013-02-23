//
//  SGBarButton.h
//  ufo
//
//  Created by SandGro on 23-02-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SGButtonUpInside)();

typedef enum {
    kBackButtonType,
    kSharingType
} SGBarButtonType;

@interface SGBarButton : UIButton
{
@private
	SGButtonUpInside _upInside;
	SGBarButtonType _buttonType;
}

#pragma mark Properties
@property (nonatomic, copy) SGButtonUpInside upInside;
@property (readonly) SGBarButtonType type;

- (id)initWithType:(SGBarButtonType)type;

@end
