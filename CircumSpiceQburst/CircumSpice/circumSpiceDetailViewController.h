//
//  circumSpiceDetailViewController.h
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircumSpiceXmlParser.h"
@interface circumSpiceDetailViewController : UIViewController
{
    IBOutlet UILabel *detailName;
     IBOutlet UILabel *detailVicinity;
     IBOutlet UILabel *detailLatitude;
     IBOutlet UILabel *detailLongitude;
     IBOutlet UILabel *detailType;
    NSMutableArray *parserData;
}

@property (nonatomic, retain) UILabel *detailName;
@property (nonatomic, retain) UILabel *detailVicinity;
@property (nonatomic, retain) UILabel *detailLatitude;
@property (nonatomic, retain) UILabel *detailLongitude;
@property (nonatomic, retain) UILabel *detailType;

- (void) stringName: (NSString *) string:(NSInteger )index; 
- (void) stringVicinity: (NSString *) string:(NSInteger )index;
- (void) stringLongitude: (NSString *) string:(NSInteger )index;
- (void) stringLatitude: (NSString *) string:(NSInteger )index;
- (void) stringType: (NSString *) string:(NSInteger )index;

-(void)count:(int)cnt;
-(void)setNameDetail:(NSMutableArray*)array;


@end
