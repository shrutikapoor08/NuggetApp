//
//  TeamController.m
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-19.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "TeamController.h"
#import "ContactCell.h"


@implementation TeamController
@synthesize team = _team;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //NSDictionary *dictzero = [jsonDict objectAtIndex:0];
   // _emailLabel.text = [dictzero objectForKey:@"Email_address"];
     NSLog(@"%@", _team);
    NSLog(@"viewdidload");
    

}



- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	//[TeamController viewWillAppear:animated];
    
    NSLog(@"%@", _team);
    NSLog(@"viewwillappear");
    [teamMembersView reloadData];

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
    
    cell.skillLabel.text = @"skillskillskill";
    cell.nameLabel.text = [_team objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"Potato.jpg"];
    
    
    
    
    return cell;
    
    
}


@end
