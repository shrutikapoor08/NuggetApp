//
//  MainViewController.m
//  OAuthStarterKit
//
//  Created by Shruti Kapoor on 2013-11-05.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize oAuthLoginView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

-(IBAction)Login:(id)sender{
    
 oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:oAuthLoginView];
    
    [self presentModalViewController:oAuthLoginView animated:YES];

    
    
}


-(void) loginViewDidFinish:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_Login release];
    [super dealloc];
}
@end
