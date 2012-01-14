//
//  circumSpiceListViewController.h
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class circumSpiceListViewController;

@interface circumSpiceListViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listElements;
    UISearchBar *searchSpot;
    UITableView *table;
    NSMutableArray *searchNameResult, *searchVicivnityResult, *searchTypeResult,*searchLongitudeResult,*searchLatitudeResult;
    IBOutlet UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
}

@property (strong) NSArray *listElements;
@property (nonatomic, retain) IBOutlet UITableView *table;

@property (nonatomic, retain) UISearchBar *searchSpot; 
-(void)setValue:(NSMutableArray*)array;
-(void)setVicinity:(NSMutableArray*)array;
-(void)setLatitude:(NSMutableArray*)array;
-(void)setLongitude:(NSMutableArray*)array;
-(void)setType:(NSMutableArray*)array;


- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
@end
