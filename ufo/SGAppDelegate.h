//
//  SGAppDelegate.h
//  ufo
//
//  Created by SandGro on 12-01-13.
//  Copyright (c) 2013 iOnyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGMainViewController;

@interface SGAppDelegate : UIResponder <UIApplicationDelegate>
{
@private
	SGMainViewController * _mainController;
}

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) SGMainViewController * mainController;


@end
