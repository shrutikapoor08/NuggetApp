//
//  MainViewController.h
//  OAuthStarterKit
//
//  Created by Shruti Kapoor on 2013-11-05.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryViewController.h"

#import "OAuthLoginView.h"

@interface MainViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *Login;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@end
