//
//  ViewController.h
//  Nugg2
//
//  Created by Shruti Kapoor on 2013-10-22.
//  Copyright (c) 2013 Nugget. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"
#import "StoryViewController.h"

@interface ViewController : UIViewController

-(IBAction)loginButton:(id)sender;

//@property (nonatomic, retain) ProfileTabView *profileTabView;
@end
