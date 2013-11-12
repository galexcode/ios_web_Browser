//
//  AppDelegate.h
//  web_Browser3
//
//  Created by Wu Ymow on 11/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    UINavigationController *naviControl;
}
@property (nonatomic,retain) UINavigationController *naviControl;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
