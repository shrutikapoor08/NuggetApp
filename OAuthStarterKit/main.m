//
//  main.m
//  OAuthStarterKit
//
//  Created by Christina Whitney on 4/11/11.
//  Copyright 2011 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
int currentUserID;

int main(int argc, char *argv[])
{
    currentUserID = 10001;
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
