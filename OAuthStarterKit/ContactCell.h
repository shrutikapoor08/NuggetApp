//
//  ContactCell.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//
//Customer cell to display contact, contact skills and image from linkedin
#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *skillLabel;
@property (nonatomic, strong) IBOutlet UILabel *belbinLabel;

@end
