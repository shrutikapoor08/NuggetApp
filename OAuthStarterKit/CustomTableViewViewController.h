//
//  CustomTableViewViewController.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
// tableview controller for managing contacts

#import <UIKit/UIKit.h>

@interface CustomTableViewViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *contact;

    IBOutlet UITableView *contactTableView;
}
@property (nonatomic, strong) IBOutlet UILabel *skillRatingLabel;
@end
