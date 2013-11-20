//
//  SkillsEditController.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
// custom table view controller allows add and delete for skills

#import <UIKit/UIKit.h>

@interface SkillsEditController : UITableViewController <UIAlertViewDelegate>
{
    NSMutableArray *skillset;
    IBOutlet UITableView *tblSkillstable;
    
}


@end
