//
//  Profile.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-11-03.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//

#import "ProfileController.h"
#import "AFNetworking.h"
extern int currentUserID;


@implementation ProfileController

@synthesize emailLabel = _emailLabel;
@synthesize nameLabel = _nameLabel;
@synthesize topBelbinLabel = _topBelbinLabel;
@synthesize skill1RatingLabel = _skill1RatingLabel;
@synthesize currID;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(IBAction)Returnkey:(id)sender
{
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (currID = 0)
    {
        currID = currentUserID;
    }
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currID],@"currentID", nil];
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getprofile.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             //NSLog (@"ARR %@", jsonDict);
             NSDictionary *dictzero = [jsonDict objectAtIndex:0];
             _emailLabel.text = [dictzero objectForKey:@"Email_address"];
             _nameLabel.text = [NSString stringWithFormat:@"%@ %@",[dictzero objectForKey:@"Given_name"], [dictzero objectForKey:@"Family_name"]];
             
             NSString *newLine = @"\n";
             NSString *belbinroles = [NSString stringWithFormat:@"%@,\n%@,\n%@",[dictzero objectForKey:@"Most_suitable_Brole"], [dictzero objectForKey:@"Secondary_suitable_Brole"], [dictzero objectForKey:@"Third_suitable_Brole"]];
             belbinroles = [belbinroles stringByReplacingOccurrencesOfString:@"\\n" withString:newLine];
             
             _topBelbinLabel.text = belbinroles;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];

    
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/gettopskill.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *jsonDict = (NSArray *) responseObject;
             NSString *skills;
             skills = [[NSString alloc]init];
             NSString *newLine = @"\n";
             for (int x = 0; x < [jsonDict count]; x++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:x];
                 if (x == 3) break;
                 else
                 {
                     if (x>0)
                     {
                        skills = [skills stringByAppendingString:@", \n"];
                     }
                     skills = [skills stringByAppendingString:[NSString stringWithFormat:@"%@", [dictzero objectForKey:@"Expertise_Name"]]];
                     
                 }
             }
             skills = [skills stringByReplacingOccurrencesOfString:@"\\n" withString:newLine];
             _skill1RatingLabel.text = skills;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];


    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end


