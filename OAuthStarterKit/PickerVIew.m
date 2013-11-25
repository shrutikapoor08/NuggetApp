//
//  PickerVIew.m
//  PickerView
//
//  Adapted from Nick Barrowclough on 05/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerVIew.h"
#import "AFNetworking.h"
#import "TeamController.h"

@implementation PickerVIew
@synthesize pickerViewContainer;
@synthesize leaderBRole = _leaderBRole;
@synthesize cp = _cp;

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
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    arrayBelbin = [[NSMutableArray alloc] init];
    [arrayBelbin addObject:@"PLANT"];
    [arrayBelbin addObject:@"RESOURCE INVESTIGATOR"];
    [arrayBelbin addObject:@"COORDINATOR"];
    [arrayBelbin addObject:@"SHAPER"];
    [arrayBelbin addObject:@"MONITOR"];
    [arrayBelbin addObject:@"TEAM WORKER"];
    [arrayBelbin addObject:@"IMPLEMENTOR"];
    [arrayBelbin addObject:@"SPECIALIST"];
    
    
    pickerViewContainer.frame = CGRectMake(0, 199, 320, 261);
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
        return [arrayBelbin count];

}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        return [arrayBelbin objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@", [arrayBelbin objectAtIndex:row]);
    _cp.leaderrole.text = [arrayBelbin objectAtIndex:row];
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareforSegue");
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_cp.expertises.text, @"Expertises", _cp.psize.text, @"Team_size",_cp.leaderrole.text , @"Belbin_role", nil];
    
    for (id key in [parameters allKeys]){
        id obj = [parameters objectForKey: key];
        NSLog(@"%@", obj);
    }
    
    //sending request to php layer
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://localhost:8888/creating_project2.php?format=json"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@TEAMTEAMTEAM", responseObject);
            
             
             if ([segue.identifier isEqualToString:@"getTeam"]) {
                 TeamController *vc = [segue destinationViewController];
                 vc.team = [[NSMutableArray alloc] init];
                 NSArray *jsonDict = (NSArray *) responseObject;
                 for (int i = 0; i < [jsonDict count]; i++)
                 {
                     NSDictionary *dictzero = [jsonDict objectAtIndex:i];
                     [vc.team addObject:[dictzero objectForKey:@"Member_ID"]];
                     
                 }
                 NSLog(@"segue: %@", vc.team);
                 [vc viewWillAppear:YES];
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving JSON" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [av show];
         }];
}


- (void)viewDidUnload
{
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

