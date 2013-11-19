//
//  CreateProject.m
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-17.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "CreateProject.h"
#import "AFNetworking.h"

@implementation CreateProject
@synthesize pleader = _pleader;
@synthesize psize = _psize;
@synthesize ptitle = _ptitle;
@synthesize pname = _pname;
@synthesize leaderrole = _leaderrole;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (IBAction)getTeam:(id)sender {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_expertises.text, @"expertises", _psize.text, @"teamSize",_leaderrole.text , @"leaderBRole", nil];
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/creating_project.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@TEAMTEAMTEAM", responseObject);
            
            
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];

   
}

- (IBAction)returnKey:(id)sender
{
    [sender resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
