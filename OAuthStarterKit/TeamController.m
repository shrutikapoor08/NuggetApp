//
//  TeamController.m
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-19.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "TeamController.h"
#import "ContactCell.h"
#import "ProfileController.h"
#import "AFNetworking.h"


@implementation TeamController
@synthesize team = _team;


- (void)viewDidLoad
{
    [super viewDidLoad];

}



- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    [teamMembersView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"profile"]) {
        NSIndexPath *selectedRowIndex = [teamMembersView indexPathForSelectedRow];
        ProfileController *vc = [segue destinationViewController];
        vc.currID = [[_team objectAtIndex:selectedRowIndex.row] intValue];
        NSLog(@"%i",vc.currID);
        [vc viewWillAppear:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_team count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //view custom skillcell
    static NSString *ccIdentifier = @"Cell";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ccIdentifier];
    if (cell == nil)
    {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ccIdentifier];
        
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[_team objectAtIndex:indexPath.row],@"currentID", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getprofile.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *jsonDict = (NSArray *) responseObject;
             NSDictionary *dictzero = [jsonDict objectAtIndex:0];
             if (indexPath.row == 0)
             {
                 cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@ - lead",[dictzero objectForKey:@"Given_name"], [dictzero objectForKey:@"Family_name"]];
             }
             else
             {
                 cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[dictzero objectForKey:@"Given_name"], [dictzero objectForKey:@"Family_name"]];
             }
             
             
             NSString *belbinroles = [NSString stringWithFormat:@"%@, %@",[dictzero objectForKey:@"Most_suitable_Brole"], [dictzero objectForKey:@"Secondary_suitable_Brole"]];
             cell.belbinLabel.text = belbinroles;
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
             for (int x = 0; x < [jsonDict count]; x++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:x];
                 if (x == 3) break;
                 else
                 {
                     if (x>0)
                     {
                         skills = [skills stringByAppendingString:@", "];
                     }
                     skills = [skills stringByAppendingString:[NSString stringWithFormat:@"%@", [dictzero objectForKey:@"Expertise_Name"]]];
                     
                 }
             }
             cell.skillLabel.text = skills; 
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];


    
    
    
    
    return cell;
    
    
}


@end
