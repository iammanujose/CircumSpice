//
//  circumSpiceMapViewController.m
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "circumSpiceMapViewController.h"
#import "sqlite3.h"
#import "circumSpiceDetailViewController.h"
#import "circumSpiceListViewController.h"

static NSMutableArray *spotName, *spotVicinity, *spotLongitude, *spotLatitude, *spotType;
static int cnt,tagid;;
@implementation circumSpiceMapViewController
@synthesize mapview;
@synthesize activityIndicator;
@synthesize viewController4=_viewController4;

-(void) xmlparser:(double)longi:(double)lati:(double)radius:(NSString *)condition
{
    NSString *urls=[[NSString alloc]initWithFormat:@"https://maps.googleapis.com/maps/api/place/search/xml?location=%f,%f&radius=%f&name=%@&sensor=false&key=AIzaSyBoUPK5kVijk2kdbXd2efVUI6LnXyti_ZY",longi,lati,radius,condition];
    NSURL *url = [[NSURL alloc] initWithString:urls];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    BOOL success =[xmlParser parse];
    
    if(!success)
        
        NSLog(@"Error Error Error!!!");
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Location", @"Location");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)goToDetailView:(id) sender
{
    circumSpiceDetailViewController *viewController4 = [[circumSpiceDetailViewController alloc] initWithNibName:@"circumSpiceDetailViewController" bundle:nil];
    
    NSLog(@"9887654%@",spotName);
    //int x=[spotName count];
    NSLog(@"tag%d",[sender tag]);
    [self.navigationController pushViewController:viewController4 animated:YES]; 
    NSLog(@"tagid%d",tagid);
    
    [viewController4 stringName:[spotName objectAtIndex:tagid] :tagid];
    
   [viewController4 count:(int)cnt]; 
   [viewController4 setNameDetail:spotName];
        
}


- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation      {
    
    MKAnnotationView *pinView = (MKAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
  
    
    
    if (!pinView) {
        
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"] ;
        
        pinView.image = [UIImage imageNamed:@"Flag3Right.png"];
        
        pinView.frame = CGRectMake(-30, 0, 60, 60); 
        
              
        pinView.canShowCallout = YES;
      
        int i;
      
        for(i=0;i<[name count];i++)        {
           
       
            if([[annotation title] isEqualToString:[name objectAtIndex:i]])
            {
                tagid=i;
                NSLog(@"in if%d",i);
             
            }
         
            
        }
  
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.tag=tagid;        
                
        NSLog(@"rojil%d",rightButton.tag);
        pinView.rightCalloutAccessoryView = rightButton;
           
        
        
    } else {
        
        pinView.annotation = annotation;
        
    }
    
    if (annotation == mapview.userLocation){
        
        return nil; //default to blue dot
        
    }
    
    return pinView;
    
}


-(void)mapannotion
{
    int i;
    for(i=0;i<[name count];i++)
    {
        
        cnt++;
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [[latitude objectAtIndex:i]doubleValue];
        annotationCoord.longitude = [[longitude objectAtIndex:i]doubleValue];
        mapview.region = MKCoordinateRegionMakeWithDistance(annotationCoord, 1000, 1000);
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
                [mapview setDelegate:self];
                
        annotationPoint.title =[name objectAtIndex:i];
        [mapview addAnnotation:annotationPoint];
       
    }
    
}

#pragma mark - View lifecycle
-(void)createdb
{
    //creating a database in the iphone directory
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *contactDB;
    
    // Get the documents directory.
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    docsDir = [dirPaths objectAtIndex:0];    
    
    // Build the path to the database file.
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"mapdata.sqlite"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //creating database Data.sqlite if not exist in the iphone direcory.
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {        
		const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {   
            NSLog(@"creating table");
            char *errMsg;
            
            //query to create database table
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS options (id INTEGER DEFAULT 1, atm INTEGER DEFAULT 1, hospital INTEGER DEFAULT 1, post INTEGER DEFAULT 1, bank INTEGER DEFAULT 1)";
            //executing query
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);                       
            sqlite3_close(contactDB);
            
        }
        else
        {
            NSLog(@"Failed to open/create database");
        }
    }
}
-(void)databaseRead
{
    sqlite3 *contactDB; //Declare a pointer to sqlite database structure
    
    //Opening database to retrive Data
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Building the path to the database file Data.sqlite
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"mapdata.sqlite"]];
    const char *dbpath=[databasePath UTF8String];
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //retrivig data from DB
        NSString *query=@"SELECT * FROM options ";
        sqlite3_stmt *statement;
        //preparing Query for Retrival
        int result=(sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement,Nil));
        if (result == SQLITE_OK)
        {
            NSLog(@"prepared");
            
        }
        else
        {
            NSLog(@"not prepared");
        }
        int i=0
        ;
        
        while (sqlite3_step(statement) == SQLITE_ROW) 
        { 
            
            char *rowData = (char *)sqlite3_column_text(statement, i);
            NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
            
            field=fieldValue;
            [self xmlparser:10.2633:76.3491:1000:@"atm"];
            [self xmlparser:10.2633:76.3491:1000:@"bank"];
            [self xmlparser:10.2633:76.3491:1000:@"hospital"];
            [self xmlparser:10.2633:76.3491:1000:@"bar"];
            [self xmlparser:10.2633:76.3491:1000:@"school"];
            i++; 
            
            
        } 
        
        
    }
    else
    {
        NSLog(@"Failed to open database");
    }
}
-(void) currentlocation
{
    mapview.showsUserLocation = YES;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    name = [[NSMutableArray alloc] init];
    vicinity = [[NSMutableArray alloc] init];
    type = [[NSMutableArray alloc] init];
    longitude = [[NSMutableArray alloc] init];
    latitude = [[NSMutableArray alloc] init];
    iconurl = [[NSMutableArray alloc] init];
    
    [self.view addSubview:activityIndicator];
    
    
    [self createdb];
  
	
}

- (void)viewDidUnload
{
    [self setMapview:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if(!x)
    {
    [self currentlocation];
    NSLog(@"current  location");
    
    
    [self databaseRead];
    NSLog(@"database read");
    [self mapannotion];
    NSLog(@"map annotation");
    
    circumSpiceListViewController *viewController2 = [[circumSpiceListViewController alloc] initWithNibName:@"circumSpiceListViewController" bundle:nil];
    
    [viewController2 setValue:name];
    [viewController2 setVicinity:vicinity];
    [viewController2 setLatitude:latitude];
    [viewController2 setLongitude:longitude];
    [viewController2 setType:type];
    
        x=TRUE;
        
    }
    [super viewDidAppear:animated];

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    circumSpiceDetailViewController *viewController4 = [[circumSpiceDetailViewController alloc] initWithNibName:@"circumSpiceDetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController4 animated:YES]; 
    
    [viewController4 stringName:[spotName objectAtIndex:[control tag]] :[control tag]];
    [viewController4 stringVicinity:[spotVicinity objectAtIndex:[control tag ]]:[control tag ]];
    
    [viewController4 stringLatitude:[spotLatitude objectAtIndex:[control tag ]]:[control tag ]];
    [viewController4 stringLongitude:[spotLongitude objectAtIndex:[control tag ]]:[control tag ]];
    [viewController4 stringType:[spotType objectAtIndex:[control tag ]]:[control tag ]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName 
     attributes:(NSDictionary *)attributeDict{
    currentElement = [elementName copy];
    if ([elementName isEqualToString:@"result"])
    { // clear out our story item caches... 
        
        item = [[NSMutableDictionary alloc] init];
        currentName = [[NSMutableString alloc] init];
        currentLongitude= [[NSMutableString alloc] init]; 
        currentLatitude = [[NSMutableString alloc] init];
        currentIconUrl = [[NSMutableString alloc] init];
        currentType = [[NSMutableString alloc] init];
        currentVicinity = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if ([currentElement isEqualToString:@"name"])
    { [currentName appendString:string]; } 
    else if ([currentElement isEqualToString:@"vicinity"])
    { [currentVicinity appendString:string];
    } else if ([currentElement isEqualToString:@"type"])
    { [currentType appendString:string];
    } else if ([currentElement isEqualToString:@"icon"])
    { [currentIconUrl appendString:string];
    } else if ([currentElement isEqualToString:@"lat"])
    { [currentLatitude appendString:string];
    } else if ([currentElement isEqualToString:@"lng"]) 
    { [currentLongitude appendString:string]; 
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"result"]) {
        
        NSString *nameWithoutSpaces = [currentName stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        NSString *typeWithoutSpaces = [currentType stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        NSString *vicinityWithoutSpaces = [currentVicinity stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        NSString *latitudeWithoutSpaces = [currentLatitude stringByReplacingOccurrencesOfString:@"\n    " withString:@""];
        NSString *longitudeWithoutSpaces = [currentLongitude stringByReplacingOccurrencesOfString:@"\n   \n  \n  " withString:@""];
        NSString *iconUrlWithoutSpaces = [currentIconUrl stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        [name addObject:nameWithoutSpaces];
        [vicinity addObject:vicinityWithoutSpaces];
        
        [type addObject:typeWithoutSpaces];
        [latitude addObject:latitudeWithoutSpaces ];
        [longitude addObject:longitudeWithoutSpaces];
        [iconurl addObject:iconUrlWithoutSpaces];
        data[index1]=currentTitle;
        index1++;
        
        
    }
    spotName=name;
    spotType=type;
    spotLatitude=latitude;
    spotLongitude=longitude;
    spotVicinity=vicinity;
    currentElementValue = nil;
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [activityIndicator stopAnimating]; 
    [activityIndicator removeFromSuperview];
    [loadLabel removeFromSuperview];
    
}


@end

