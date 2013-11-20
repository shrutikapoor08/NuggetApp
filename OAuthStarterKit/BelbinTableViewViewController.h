//
//  BelbinTableViewViewController.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-22.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
// custom table view controller allows reordering of belbin skills

#import <UIKit/UIKit.h>

@interface BelbinTableViewViewController : UITableViewController {
    IBOutlet UITableView *tblSimpleTable;
    NSMutableArray *belbinroles;

}
- (IBAction) EditTable:(id)sender;

@end
