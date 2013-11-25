//
//  BelbinTableViewViewController.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-22.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
// custom table view controller allows reordering of belbin skills

#import "BelbinTableViewViewController.h"
#import "AFNetworking.h"
extern int currentUserID;

@interface BelbinTableViewViewController ()

@end

@implementation BelbinTableViewViewController

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


    NSMutableArray *belbinlist = [[NSMutableArray alloc] initWithObjects:@"PLANT", @"RESOURCE INVESTIGATOR", @"MONITOR EVALUATOR", @"COORDINATOR", @"IMPLEMENTER", @"COMPLETER FINISHER", @"TEAMWORKER", @"SHARPER", @"SPECIALIST", nil];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID", nil];
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/getprofile.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"%@", responseObject);
             NSArray *jsonDict = (NSArray *) responseObject;
             //NSLog (@"ARR %@", jsonDict);
             NSDictionary *dictzero = [jsonDict objectAtIndex:0];
             
             belbinroles = [[NSMutableArray alloc] init];
             [belbinlist removeObject: [dictzero objectForKey:@"Most_unsuitable_Brole"]];
             [belbinlist removeObject: [dictzero objectForKey:@"Secondary_unsuitable_Brole"]];
             [belbinlist removeObject: [dictzero objectForKey:@"Third_unsuitable_Brole"]];
             [belbinlist removeObject: [dictzero objectForKey:@"Most_suitable_Brole"]];
             [belbinlist removeObject: [dictzero objectForKey:@"Secondary_suitable_Brole"]];
             [belbinlist removeObject: [dictzero objectForKey:@"Third_suitable_Brole"]];
 
             NSLog(@"%@", belbinlist);
             
             [belbinroles addObject:[dictzero objectForKey:@"Most_suitable_Brole"]];
             [belbinroles addObject:[dictzero objectForKey:@"Secondary_suitable_Brole"]];
             [belbinroles addObject:[dictzero objectForKey:@"Third_suitable_Brole"]];
            //compare against array
             for(int x = 0; x<[belbinlist count]; x++)
             {
                 [belbinroles addObject:[belbinlist objectAtIndex:x]];
             }
             [belbinroles addObject:[dictzero objectForKey:@"Third_unsuitable_Brole"]];
             [belbinroles addObject:[dictzero objectForKey:@"Secondary_unsuitable_Brole"]];
             [belbinroles addObject:[dictzero objectForKey:@"Most_unsuitable_Brole"]];
             
             
            //NSLog(@"%@", [belbinroles objectAtIndex:0]);
             
             [self.tableView reloadData];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];

    
    //create edit button in navigation bar
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(EditTable:)];
	[self.navigationItem setRightBarButtonItem:addButton];
     [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];

}

- (IBAction) EditTable:(id)sender{
    //allow editing table
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[tblSimpleTable setEditing:NO animated:NO];
		[tblSimpleTable reloadData];
		[self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[tblSimpleTable setEditing:YES animated:YES];
		[tblSimpleTable reloadData];
		[self.navigationItem.leftBarButtonItem setTitle:@"Done"];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
    return [belbinroles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell ==nil){
        cell = [[UITableViewCell alloc ]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
	cell.textLabel.text = [belbinroles objectAtIndex:indexPath.row];
    return cell;
    
    
   
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{

    //rearrange belbin roles in the UI.
    NSObject *item = [belbinroles objectAtIndex:fromIndexPath.row];
	[belbinroles removeObject:item];
	[belbinroles insertObject:item atIndex:toIndexPath.row];
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID],@"currentID",[belbinroles objectAtIndex:0], @"mostsuitable", [belbinroles objectAtIndex:1], @"secondsuitable", [belbinroles objectAtIndex:2], @"thirdsuitable", [belbinroles objectAtIndex:8], @"mostunsuitable", [belbinroles objectAtIndex:7], @"secondunsuitable", [belbinroles objectAtIndex:6], @"thirdunsuitable",nil];
  
    
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/updatebelbin.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           // NSLog(@"%@", responseObject);
      
                     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:                                                     [NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];


           [self.tableView reloadData];

}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


@end
