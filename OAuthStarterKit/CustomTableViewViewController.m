//
//  CustomTableViewViewController.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//  table view controller for managing contacts

#import "CustomTableViewViewController.h"
#import "ContactCell.h"
#import "SkillsView.h"
#import "AFNetworking.h"
extern int currentUserID;

@interface CustomTableViewViewController ()

@end

@implementation CustomTableViewViewController
@synthesize skillRatingLabel = _skillRatingLabel;

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

    //query contact here
    
    
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    contact = [[NSMutableArray alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID", nil];
    
    //is conneter in database
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getcontact1.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             for (int i = 0; i < [jsonDict count]; i++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:i];
                 [contact addObject:[dictzero objectForKey:@"Connetee_Member_or_Team"]];
                 
             }
             //NSLog(@"%@", contact);
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];
    
    //current user is connettee in db
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getcontact2.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             for (int i = 0; i < [jsonDict count]; i++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:i];
                 [contact addObject:[dictzero objectForKey:@"Conneter_Member_or_Team"]];
                 
             }
             //NSLog(@"%@", contact);
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];


    
    
    contactTableView.dataSource = self;
    contactTableView.delegate = self;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"endorsecontact"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        SkillsView *vc = [segue destinationViewController];
        vc.cname = [contact objectAtIndex:selectedRowIndex.row];
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
    return [contact count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create contact cell here

    static NSString *ccIdentifier = @"Cell";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ccIdentifier];
    if (cell == nil)
    {
         cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ccIdentifier];

    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[contact objectAtIndex:indexPath.row],@"currentID", nil];
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
