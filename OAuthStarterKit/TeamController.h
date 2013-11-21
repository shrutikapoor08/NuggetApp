//
//  TeamController.h
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-19.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
   
    NSArray *team;
    IBOutlet UITableView *teamMembersView;
}
@property (nonatomic, strong) id responseObject;
@end
