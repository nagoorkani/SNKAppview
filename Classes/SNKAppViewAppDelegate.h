//
//  SNKAppViewAppDelegate.h
//  SNKAppView
//
//  Created by Nagoor Kani Sheik Maideen on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNKAppViewViewController;

@interface SNKAppViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SNKAppViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SNKAppViewViewController *viewController;

@end

