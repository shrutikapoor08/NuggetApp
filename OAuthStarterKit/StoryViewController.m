//
//  MainViewController.m
//  OAuthStarterKit
//
//  Created by Shruti Kapoor on 2013-10-31.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()

@end

@implementation StoryViewController
@synthesize oAuthLoginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)loginButton:(id)sender

{
    
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:oAuthLoginView];
    
    [self presentModalViewController:oAuthLoginView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    
    if(LOGIN_VIEW_DID_FINISH) { NSLog(@"Loggedin");}
    
}


-(BOOL) loginViewDidFinish:(NSNotification*)notification
{
  
//[self performSegueWithIdentifier:@"afterLoginScreen" sender:self];
    
    return YES;
    //[self windowFromStoryboard:@"AfterLogin" onScreen:self];
    
  //  [self performSegueWithIdentifier: @"mainApp" sender: self];
    // We're going to do these calls serially just for easy code reading.
    // They can be done asynchronously
    // Get the profile, then the network updates
    
  // [self performSegueWithIdentifier:@"mainApp" sender:self];
    //  [self dismissModalViewControllerAnimated:YES];
      // UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"" bundle:nil];
  //  StoryViewController* myStoryBoardInitialViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    
    //  [self.navigationController pushViewController:myStoryBoardInitialViewController animated:YES];
    // [self profileApiCall];
    // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //  ProfileTabView * yourView = (ProfileTabView *)[storyboard instantiateViewControllerWithIdentifier:@"nuggID"];
    //   [self.presentedViewController:yourView animated:YES completion:^{}];
	
    //[self switchToStoryBoard];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
