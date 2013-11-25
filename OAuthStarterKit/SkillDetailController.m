//
//  SkillDetailController.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-11-09.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//

#import "SkillDetailController.h"
#import "ContactCell.h"
#import "AFNetworking.h"
#import "ProfileController.h"
extern int currentUserID;

@interface SkillDetailController ()

@end


@implementation SkillDetailController
@synthesize passedval = _passedval;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    contacts = [[NSMutableArray alloc] init];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID", _passedval,@"skillname",nil];
    
    for (id key in [parameters allKeys]){
        id obj = [parameters objectForKey: key];
        NSLog(@"%@", obj);
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getraters.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             for (int i = 0; i < [jsonDict count]; i++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:i];
                 [contacts addObject:[dictzero objectForKey:@"Member_ID"]];
                 
             }
             //NSLog(@"%@", contacts);
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"profile"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        ProfileController *pc = [segue destinationViewController];
        pc.currID = [[contacts objectAtIndex:selectedRowIndex.row] intValue];
        //NSLog(@"%i",vc.currID);
        [pc viewWillAppear:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create contact cell here
    NSLog(@"Creating cell");
    
    static NSString *ccIdentifier = @"Cell";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ccIdentifier];
    if (cell == nil)
    {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ccIdentifier];
        
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[contacts objectAtIndex:indexPath.row],@"currentID", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getprofile.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *jsonDict = (NSArray *) responseObject;
             NSDictionary *dictzero = [jsonDict objectAtIndex:0];
             cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[dictzero objectForKey:@"Given_name"], [dictzero objectForKey:@"Family_name"]];
             
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
