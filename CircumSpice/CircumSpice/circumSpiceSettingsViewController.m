//
//  circumSpiceSettingsViewController.m
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "circumSpiceSettingsViewController.h"

@implementation circumSpiceSettingsViewController

@synthesize slideDistance,slidevalue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) sliderValueChanged:(UISlider *)sender
{
    slidevalue.text = [NSString stringWithFormat:@"%.1f", [sender value]]; 
}
- (IBAction) changeButtonPressed:(id)sender
{
    NSString *textValue = [slidevalue text];  
    float value = [textValue floatValue];  
    if (value < 0) value = 0;  
    if (value > 100) value = 100;  
    slideDistance.value = value;  
    slidevalue.text = [NSString stringWithFormat:@"%.1f", value];  
    if ([slidevalue canResignFirstResponder]) [slidevalue resignFirstResponder]; }

@end
