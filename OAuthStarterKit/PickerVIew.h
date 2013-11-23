//
//  PickerVIew.h
//  PickerView
//
//  Adapted from Nick Barrowclough on 05/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CreateProject.h"

#define BELBIN 0

@interface PickerVIew : UIViewController

<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{
    
    NSMutableArray *arrayBelbin;
}

@property (strong, nonatomic) IBOutlet UIView *pickerViewContainer;
@property (strong, nonatomic) IBOutlet UITextField *leaderBRole;
@property (strong, nonatomic) IBOutlet CreateProject *cp;
@property (strong, nonatomic) IBOutlet UIPickerView *BelbinPicker;



@end
