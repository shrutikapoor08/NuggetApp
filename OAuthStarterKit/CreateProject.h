//
//  CreateProject.h
//  OAuthStarterKit
//
//  Created by Alexis Katigbak on 2013-11-17.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProject : UIView
{
    
}
@property (nonatomic, strong) IBOutlet UITextField *pname;
@property (nonatomic, strong) IBOutlet UITextField *pleader;
@property (nonatomic, strong) IBOutlet UITextField *psize;
@property (nonatomic, strong) IBOutlet UITextField *leaderrole;
@property (nonatomic, strong) IBOutlet UITextField *expertises;
- (IBAction)returnKey:(id)sender;

@end
