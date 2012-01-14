//
//  circumSpiceSettingsViewController.h
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@class circumSpiceSettingsViewController;

@interface circumSpiceSettingsViewController : UIViewController
{
    
//    IBOutlet UISlider *slideDistance;
//    IBOutlet UILabel *slidevalue;
    UISwitch *spotSelector;
    NSString *databasePath;

    
}

@property (nonatomic,retain) IBOutlet UISwitch *spotSelector;
- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) changeButtonPressed:(id)sender;
-(IBAction)selectSpot:(id)sender;
-(void)insertIntoDb;

@end
