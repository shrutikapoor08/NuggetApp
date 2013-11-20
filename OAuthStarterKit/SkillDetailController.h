//
//  SkillDetailController.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-11-09.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillDetailController : UITableViewController
{
    NSMutableArray *contacts;
}
@property (nonatomic, copy) IBOutlet NSString *passedval;
@end
