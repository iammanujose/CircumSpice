//
//  circumSpiceMapViewController.h
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class circumSpiceDetailViewController;

@interface circumSpiceMapViewController : UIViewController <NSXMLParserDelegate,MKMapViewDelegate>{
    NSInteger rownum;
    NSString *databasePath;
    //NSString *field;
    MKMapView *mapview;
    NSMutableString *currentElementValue;
    NSMutableArray *name;
    NSMutableArray *lat;
    NSMutableArray *lng;
    NSInteger index;
    NSInteger index1;
    NSString *data[100];
    NSMutableArray *map;
    NSMutableArray *vicinity;
    NSMutableArray *type;
    NSMutableArray *latitude;
    NSMutableArray *longitude;
    NSMutableArray *iconurl;
    NSMutableArray *reference;
    IBOutlet UILabel *loadLabel;
    BOOL x;
    int field;
    NSInteger counts;
    NSInteger countNumber[10];
    
    
    
    NSMutableDictionary * stories; // a temporary item; added to the "stories" array one at a time, and cleared for the next one 
    NSMutableDictionary * item; // it parses through the document, from top to bottom...
    // we collect and cache each sub-element value, and then save each item to our array. // we use these to track each current item, until it's ready to be added to the "stories" array 
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink; 
    NSMutableString *currentName,*currentVicinity, *currentType,*currentLongitude, *currentLatitude, *currentIconUrl, *currentReference;
}
//@property (nonatomic,retain) circumSpiceDetailViewController *viewController4;
@property (nonatomic,retain) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,  retain) circumSpiceDetailViewController *viewController4;
//@property (strong, nonatomic) UINavigationController *navigationController;
//-(IBAction)goToDetailView:(UIView *)sender;
-(void)databaseRead;
@end
