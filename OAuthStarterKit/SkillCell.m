//
//  SkillCell.m
//  Nugget
//
//  Created by Alexis Katigbak on 2013-10-30.
//  Copyright (c) 2013 Alexis Katigbak. All rights reserved.
//  custom cell for skill information

#import "SkillCell.h"
#import "AFNetworking.h"

@implementation SkillCell
extern int currentUserID;
@synthesize resultLabel = _resultLabel;
@synthesize skillLabel = _skillLabel;
@synthesize ratee = _ratee;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _rating.continuous = NO;
        }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Scroll:(id)sender {
    _resultLabel.text = [NSString stringWithFormat:@"%.0f", _rating.value];
    NSLog(@"Saving endorsement");
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", currentUserID], @"rater", _ratee, @"ratee", _skillLabel.text,@"skillname", _resultLabel.text, @"rating", nil];
    
        
        //delete and create new entry
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://localhost:8888/deleteendorsement.php?format=json"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
             }];
        
        [manager GET:[NSString stringWithFormat:@"http://localhost:8888/insertendorsement.php?format=json"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
             }];
        
        
        
        //calculate member_skills - overall expertise rating here
        [manager GET:[NSString stringWithFormat:@"http://localhost:8888/calculaterating.php?format=json"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
             }];
        
        
        
    

}

@end
