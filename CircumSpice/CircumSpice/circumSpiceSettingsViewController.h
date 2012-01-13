//
//  circumSpiceSettingsViewController.h
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class circumSpiceSettingsViewController;

@interface circumSpiceSettingsViewController : UIViewController
{
    
    IBOutlet UISlider *slideDistance;
    IBOutlet UILabel *slidevalue;
  
    
}
@property (nonatomic, retain) UISlider *slideDistance;
@property (nonatomic, retain) UILabel *slidevalue;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) changeButtonPressed:(id)sender;

@end
