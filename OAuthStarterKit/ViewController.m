//
//  ViewController.m
//  Nugg2
//
//  Created by Shruti Kapoor on 2013-10-22.
//  Copyright (c) 2013 Nugget. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

//@synthesize profileTabView;

-(IBAction)loginButton:(id)sender
{
    [self performSegueWithIdentifier:@"oauthview" sender:self];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}


    
//
//    profileTabView = [[ProfileTabView alloc] initWithNibName:nil bundle:nil];
//    [profileTabView retain];
    
//    // register to be told when the login is finished
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loginViewDidFinish:)
//                                                 name:@"loginViewDidFinish"
//                                               object:profileTabView];

    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
