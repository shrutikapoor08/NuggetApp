//
//  PickerVIew.m
//  PickerView
//
//  Adapted from Nick Barrowclough on 05/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerVIew.h"
#import "AFNetworking.h"
#import "CustomTableViewViewController.h"

@implementation PickerVIew
@synthesize pickerViewContainer;
@synthesize leaderBRole = _leaderBRole;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayBelbin = [[NSMutableArray alloc] init];
    [arrayBelbin addObject:@"Plant"];
    [arrayBelbin addObject:@"Resource Investigator"];
    [arrayBelbin addObject:@"Coordinator"];
    [arrayBelbin addObject:@"Shaper"];
    [arrayBelbin addObject:@"Monitor"];
    [arrayBelbin addObject:@"Team Worker"];
    [arrayBelbin addObject:@"Implementor"];

    
    pickerViewContainer.frame = CGRectMake(0, 199, 320, 261);
    


}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
        return [arrayBelbin count];

}


- (IBAction)Show:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 307, 320, 261);
    [UIView commitAnimations];
}


- (IBAction)Hide:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 600, 320, 261);
    [UIView commitAnimations];
}




- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row{
        return [arrayBelbin objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row {
    _leaderBRole.text = [arrayBelbin objectAtIndex:[pickerView selectedRowInComponent:0]];
}


- (IBAction)showBtn:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 199, 320, 261);
    [UIView commitAnimations];
}


- (IBAction)hideBtn:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 460, 320, 261);
    [UIView commitAnimations];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidUnload
{
    [self setLeaderBRole:nil];
    [self setPickerViewContainer:nil];
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end

