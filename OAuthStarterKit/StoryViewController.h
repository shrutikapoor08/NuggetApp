//
//  MainViewController.h
//  OAuthStarterKit
//
//  Created by Shruti Kapoor on 2013-10-31.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"



@interface StoryViewController : UIViewController

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@end
