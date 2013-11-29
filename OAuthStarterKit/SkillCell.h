//
//  SkillCell.h
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//  custom cell for skill information

#import <UIKit/UIKit.h>

@interface SkillCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *skillLabel;
@property (nonatomic, strong) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) IBOutlet UISlider *rating;
@property NSInteger ratee;
- (IBAction)Scroll:(id)sender;


@end
