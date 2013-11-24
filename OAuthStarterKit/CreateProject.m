//
//  CreateProject.m
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-17.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "CreateProject.h"
#import "AFNetworking.h"
#import "TeamController.h"

@implementation CreateProject
@synthesize pleader = _pleader;
@synthesize psize = _psize;
@synthesize pname = _pname;
@synthesize leaderrole = _leaderrole;
@synthesize expertises = _expertises;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}




- (IBAction)returnKey:(id)sender
{
    [sender resignFirstResponder];
}



@end
