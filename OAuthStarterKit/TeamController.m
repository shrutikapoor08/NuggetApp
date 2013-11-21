//
//  TeamController.m
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-19.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "TeamController.h"
#import "ContactCell.h"

@interface TeamController ()

@end

@implementation TeamController
@synthesize responseObject = _responseObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", responseObject);
    team = (NSArray *) _responseObject;
    //NSDictionary *dictzero = [jsonDict objectAtIndex:0];
   // _emailLabel.text = [dictzero objectForKey:@"Email_address"];

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [team count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //view custom skillcell
    NSDictionary *currentmember = [team objectAtIndex:indexPath.row];
    static NSString *ccIdentifier = @"Cell";
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ccIdentifier];
    if (cell == nil)
    {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ccIdentifier];
        
    }
    
    cell.skillLabel.text = @"skillskillskill";
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[currentmember objectForKey:@"Given_name"], [currentmember objectForKey:@"Family_name"]];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"Potato.jpg"];
    
    
    
    
    return cell;
    
    
}


@end
