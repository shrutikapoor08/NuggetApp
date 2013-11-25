//
//  SkillsView.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//  customer view controller that allows viewing of skills from a custom contact cell

#import <UIKit/UIKit.h>

@interface SkillsView : UIViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

{
    NSMutableArray *skills;
    IBOutlet UITableView *skillsTableView;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *topbelbin;
@property (nonatomic, copy) NSString *cname;
- (IBAction)Save:(id)sender;
- (IBAction)Help:(id)sender;

@end


