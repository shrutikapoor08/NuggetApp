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
                 [contacts addObject:[NSString stringWithFormat:@"%@ %@",[dictzero objectForKey:@"Given_name"], [dictzero objectForKey:@"Family_name"]]];
                 
             }
             NSLog(@"%@", contacts);
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];
    
    
    
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
    
    
    
    cell.nameLabel.text = [contacts objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"Potato.jpg"]; //change later to object at index
    cell.skillLabel.text = @"Skill1 (1), Skill2 (2), Skill3 (3), Skill4 (4), Skill (5)"; //change later from new mutable array
    
    return cell;

}



@end
