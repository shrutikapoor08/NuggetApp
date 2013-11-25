//
//  SkillsEditController.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//custom table view controller allows add and delete for skills

#import "SkillsEditController.h"
#import "AFNetworking.h"
#import "SkillDetailController.h"
extern int currentUserID;

@interface SkillsEditController ()

@end

@implementation SkillsEditController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"skilldetail"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        SkillDetailController *vc = [segue destinationViewController];
        //NSLog(@"%@", [skillset objectAtIndex:selectedRowIndex.row]);
        vc.passedval = [[skillset objectAtIndex:selectedRowIndex.row] substringFromIndex:2];
        //vc.passedval = [skillset objectAtIndex:selectedRowIndex.row];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Skills";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertSkill)];

    self.navigationItem.rightBarButtonItem = addButton;

}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    //pull out skills data here
    
    skillset = [[NSMutableArray alloc] init];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID", nil];
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getskills.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             for (int i = 0; i < [jsonDict count]; i++)
             {
                 NSDictionary *dictzero = [jsonDict objectAtIndex:i];
                 [skillset addObject:[NSString stringWithFormat:@"%@ %@",[dictzero objectForKey:@"Expertise_rating"], [dictzero objectForKey:@"Expertise_Name"]]];
             }
             //NSLog(@"%@", skillset);
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];
    
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [tblSkillstable setEditing:editing animated:animated];
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
    return [skillset count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    if (cell ==nil){
        cell = [[UITableViewCell alloc ]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	cell.textLabel.text = [skillset objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (BOOL) tableView:(UITableView*) tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        
        //remove from members table and endorsements table
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID", [[skillset objectAtIndex:indexPath.row] substringFromIndex:2],@"skillname",nil];
        for (id key in [parameters allKeys]){
            id obj = [parameters objectForKey: key];
            NSLog(@"%@", obj);
        }
        
        //remove from array
        [skillset removeObjectAtIndex:indexPath.row];
        
        //sending request to php layer
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://localhost:8888/deleteskill.php?format=json"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //php runs code to delete from members and endorsements table
                //not sure if we want to delete the endorsements stuff? something to bring up
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
             }];

        //remove from table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void) insertSkill
{
    //insert skill by creating an alert view for user input
    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:@"Enter new skill" message:@""delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    addAlert.show;
    
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
    }
    else if (buttonIndex == 1)
    {
        if([skillset count] >= 10)
        {
            return;
        }
        
        //add to array and table view once the okay has been cleared in the alert
        NSString *temp = [alertView textFieldAtIndex:0].text;
        if(!skillset)
        {
            skillset = [[NSMutableArray alloc] init];
        }
        [skillset insertObject:temp atIndex:0];
        NSIndexPath *i = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[i] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID",temp,@"skillname",nil];
        
        //sending request to php layer
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://localhost:8888/insertskill.php?format=json"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
             }];

        
    }
}


@end
