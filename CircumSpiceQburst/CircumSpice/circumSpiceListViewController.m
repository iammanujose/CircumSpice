//
//  circumSpiceListViewController.m
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "circumSpiceListViewController.h"
#import "circumSpiceDetailViewController.h"
#import "circumSpiceMapViewController.h"


static NSMutableArray *list, *subtitle,*latitude,*longitude,*type;

@implementation circumSpiceListViewController


@synthesize listElements;
@synthesize  table,searchSpot;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Detail" style:UIBarButtonItemStyleBordered target:self action:@selector(goToSubView)];
    //self.navigationItem.rightBarButtonItem = nextButton; 
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"List", @"List");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
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
    
    //self.listElements= [[NSArray alloc] initWithObjects:
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    table.delegate=self;
    //[self setValue:listElements];
    searchNameResult = [[NSMutableArray alloc] init];
    searchNameResult=[list mutableCopy];
    searchVicivnityResult = [[NSMutableArray alloc] init];
    searchVicivnityResult=[subtitle mutableCopy];
    searchTypeResult = [[NSMutableArray alloc] init];
    searchTypeResult=[type mutableCopy];
    searchLongitudeResult = [[NSMutableArray alloc] init];
    searchLongitudeResult=[longitude mutableCopy];    
    searchLatitudeResult = [[NSMutableArray alloc] init];
    searchLatitudeResult=[latitude mutableCopy];
    self.table.tableHeaderView=searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [super viewDidLoad];
    searching = NO;
    letUserSelectRow = YES;
    //NSLog(@"%@",list);
    //NSLog(@"%@",searchNameResult);
    [self.table reloadData];
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

//- (void)goToDetailView
//{
//    circumSpiceDetailViewController *viewController4 = [[circumSpiceDetailViewController alloc] initWithNibName:@"circumSpiceDetailViewController" bundle:[NSBundle mainBundle]];
//    
//    [self.navigationController pushViewController:viewController4 animated:YES];
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    /// return [listOfStates count];
    //    return [self.listElements count]; 
    //return [list count]; 
    //if (searching)
    return [searchNameResult count];
    //else {
    
    //Number of rows it should expect should be based on the section
    //NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    //NSArray *array = [dictionary objectForKey:@"Countries"];
    // return [list count];
    // }
    //[listElements ]
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Hello");
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    // NSLog(@"-nnn->%@",);
    
    // Configure the cell.
    //   cell.textLabel.text=@"minna";
    if(indexPath !=NULL){
       // NSLog(@"index path %d",indexPath.row);
        NSString *subtit = [searchVicivnityResult objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = subtit;
        cell.textLabel.text = [searchNameResult objectAtIndex: [indexPath row]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    circumSpiceDetailViewController *viewController4 = [[circumSpiceDetailViewController alloc] initWithNibName:@"circumSpiceDetailViewController" bundle:nil];
    
    //    
    [self.navigationController pushViewController:viewController4 animated:YES];
    //    if(searching){
    
    [viewController4 stringName:[searchNameResult objectAtIndex:indexPath.row]:indexPath.row];
    [viewController4 stringVicinity:[searchVicivnityResult objectAtIndex:indexPath.row]:indexPath.row];
    [viewController4 stringLongitude:[searchLongitudeResult objectAtIndex:indexPath.row]:indexPath.row];
    
    [viewController4 stringLatitude:[searchLatitudeResult objectAtIndex:indexPath.row]:indexPath.row];
    
    [viewController4 stringType:[searchTypeResult objectAtIndex:indexPath.row]:indexPath.row];
    //    }
    //    else {
    //    
    //    [viewController4 stringName:[list objectAtIndex:indexPath.row]:indexPath.row];
    //    
    //    [viewController4 stringVicinity:[subtitle objectAtIndex:indexPath.row]:indexPath.row];
    //   
    //    [viewController4 stringLongitude:[longitude objectAtIndex:indexPath.row]:indexPath.row];
    //
    //    [viewController4 stringLatitude:[latitude objectAtIndex:indexPath.row]:indexPath.row];
    //    
    //    [viewController4 stringType:[type objectAtIndex:indexPath.row]:indexPath.row];
    //    }
    // // [self goToDetailView];  
}

-(void)setValue:(NSMutableArray*)array
{ 
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    newArray = [array mutableCopy];
    NSLog(@"from list object call %@",newArray);
    
    //int x=[newArray count];
    list=newArray;
    
    //z=x;
    
}
-(void)setVicinity:(NSMutableArray *)array
{ 
    NSMutableArray *newVArray = [[NSMutableArray alloc] init];
    newVArray = [array mutableCopy];
    NSLog(@"from list object call %@",newVArray);
    
    //int x=[newArray count];
    subtitle=newVArray;
    
    //z=x;
    
}
-(void)setLatitude:(NSMutableArray *)array
{
    NSMutableArray *newLArray = [[NSMutableArray alloc] init];
    newLArray = [array mutableCopy];
    //NSLog(@"%@",newLArray);
    
    //int x=[newArray count];
    latitude=newLArray;
    
    //z=x;
    
}
-(void)setLongitude:(NSMutableArray *)array

{ 
    NSMutableArray *newLoArray = [[NSMutableArray alloc] init];
    newLoArray = [array mutableCopy];
//<<<<<<< HEAD
   // NSLog(@"%@",newLoArray);
//=======
    //NSLog(@"%@",newLoArray);
//>>>>>>> 7eb7314e0ea52af2ab8c6f9758d573dce9a335fe
    
    //int x=[newArray count];
    longitude=newLoArray;
    
    //z=x;
    
}
-(void)setType:(NSMutableArray *)array
{ 
    NSMutableArray *newTArray = [[NSMutableArray alloc] init];
    newTArray = [array mutableCopy];
    //NSLog(@"%@",newTArray);
    
    //int x=[newArray count];
    type=newTArray;
    
    //z=x;
    
}
-(void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    
    searching = YES;
    letUserSelectRow = NO;
    self.table.scrollEnabled = NO;
    //vicivnityResult=[[NSMutableArray alloc]init];
    //Add the done button.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]                                            initWithBarButtonSystemItem:UIBarButtonSystemItemDone                                              target:self action:@selector(doneSearching_Clicked:)] ;
}
- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    //[copyListOfItems removeAllObjects];
    [searchNameResult removeAllObjects];
    [searchVicivnityResult removeAllObjects];
    [searchTypeResult removeAllObjects];
    [searchLatitudeResult removeAllObjects];
    [searchLongitudeResult removeAllObjects];
    
    if([searchText length] > 0) {
        
        searching = YES;
        letUserSelectRow = YES;
        self.table.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        
        searching = NO;
        letUserSelectRow = NO;
        self.table.scrollEnabled = NO;
    }
    
    [self.table reloadData];
}
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    [self searchTableView];
    [searchBar resignFirstResponder];
}

- (void) searchTableView {
    
    NSString *searchText = searchBar.text;
    //NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    int i=0;
    
    for (NSString *sTemp in list)
    { 
        //i++;
        //NSLog(@"in for loop");
        NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0){
            [searchNameResult addObject:sTemp];
            [searchVicivnityResult addObject:[subtitle objectAtIndex:i]];
            [searchTypeResult addObject:[type objectAtIndex:i]];
            [searchLatitudeResult addObject:[latitude objectAtIndex:i]];
            [searchLongitudeResult addObject:[longitude objectAtIndex:i]];
            //NSLog(@"siiii--->%d",i);
        }
        i++;
        // NSLog(@"hii--- %@",copyListOfItems);
    }
    
    //NSLog(@"hii %@",copyListOfItems);
    //searchArray = nil;
}
- (void) doneSearching_Clicked:(id)sender {
    
    //searchBar.text = @"";
    [searchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    self.navigationItem.rightBarButtonItem = nil;
    self.table.scrollEnabled = YES;
    //NSLog(@"hii %@",copyListOfItems);
    //[self.table reloadData];
    //NSLog(@"hii %@",copyListOfItems);
}
@end
