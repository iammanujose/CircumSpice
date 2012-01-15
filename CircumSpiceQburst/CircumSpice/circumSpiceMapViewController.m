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
#import "circumSpiceSettingsViewController.h"

static NSMutableArray *spotName, *spotVicinity, *spotLongitude, *spotLatitude, *spotType;
static NSMutableArray *categoryCount;
static int cnt,tagid;;
@implementation circumSpiceMapViewController
@synthesize mapview;
@synthesize activityIndicator;
//static sqlite3_stmt *addStmt = nil;

@synthesize viewController4=_viewController4;

-(void) xmlparser:(double)longi:(double)lati:(double)radius:(NSString *)condition:(NSInteger)categoryNumber
{
    //int i;
    index1=0;
    NSLog(@"xml parser");
    NSString *urls=[[NSString alloc]initWithFormat:@"https://maps.googleapis.com/maps/api/place/search/xml?location=%f,%f&radius=%f&name=%@&sensor=false&key=AIzaSyBNa8_9X2uUQh7y1ee85w1jbltBOK_kOE0",longi,lati,radius,condition];
    NSURL *url = [[NSURL alloc] initWithString:urls];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    BOOL success =[xmlParser parse];
    
    if(!success)
        
        NSLog(@"Error Error Error!!!");
    countNumber[categoryNumber]=counts;
    
  
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

- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation      {
    
    MKAnnotationView *pinView = (MKAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
  int i;
    i=0;
    NSLog(@"Mk annotation delegate fun");
    
    if (!pinView) {
        
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"] ;
        
        pinView.image = [UIImage imageNamed:@"gpspolice.png"];
        
        pinView.frame = CGRectMake(-20, 0, 40, 40); 
        
              
        pinView.canShowCallout = YES;
      
  
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
       
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
    NSLog(@"mapp annotation fun");
    int i;
    for(i=0;i<[name count];i++)
    {
        
        cnt++;
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [[latitude objectAtIndex:i]doubleValue];
        annotationCoord.longitude = [[longitude objectAtIndex:i]doubleValue];
        mapview.mapType=MKMapTypeStandard;
        mapview.region = MKCoordinateRegionMakeWithDistance(annotationCoord, 5000, 5000);
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
    NSLog(@"create db fun");
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
            const char *sql_stmt = "CREATE TABLE options (school INTEGER DEFAULT (1) ,atm INTEGER DEFAULT (1) ,hospital INTEGER DEFAULT (1) ,post INTEGER DEFAULT (1) ,bank INTEGER DEFAULT (1) ,bar )";
            //executing query
            
            sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg);                       
            sqlite3_close(contactDB);
            
        }
        else
        {
            NSLog(@"Failed to open/create database");
        }
    }
    //circumSpiceSettingsViewController *viewController3=[[circumSpiceSettingsViewController alloc] initWithNibName:@"circumSpiceSettingsViewController" bundle:nil];
    //[self insertIntoDb];
    
    
}
-(void)databaseRead
{
    NSLog(@"database read fun");
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
        int i;
        
        
        
          while (sqlite3_step(statement) == SQLITE_ROW) 
           { 
               for(i=0;i<6;i++)
               { 
            
            char *rowData = (char *)sqlite3_column_text(statement, i);
           // NSInteger rowData=(NSInteger )sqlite3_column_text(statement, i);
            NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
            field=[fieldValue intValue];
            //field=fieldValue;
            
            
            //float stringFloat = [myString floatValue];
             
           //NSLog(@"field%d",field);
           //if(field == 1)
          // {
                   NSLog(@"calling xml parser for atm,bank");
                if(field == 1 && i==0)
                {
                   // NSLog(@"field%@",field);
                   //NSLog(@"in if----1");  
                                           
                  [self xmlparser:10.2633:76.3491:2000:@"school":i];
                    
               }
               
               
               if(field == 1 && i==1)
               
               {
                  //NSLog(@"in if----2");
                  [self xmlparser:10.2633:76.3491:2000:@"atm":i]; 
               }
               if(field == 1 && i==2)
               {
                   //NSLog(@"in if----3");
                   [self xmlparser:10.2633:76.3491:2000:@"hospital":i];
                   
               }
               if(field == 1 && i==3)
               {
                   //NSLog(@"in if----4");
                 [self xmlparser:10.2633:76.3491:2000:@"post":i];
                      
               }
                   if(field == 1 && i==4)
                   {
                       [self xmlparser:10.105768:76.353264:2000:@"bank":i];
                       //NSLog(@"in if----5");
                   }
                   if(field == 1 && i==5)
                   {
                       [self xmlparser:10.2633:76.3491:2000:@"bar":i];
                     //  NSLog(@"in if----6");
                   }

           
            }   
           
            
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
    NSLog(@"view did load fun");
    
    [super viewDidLoad];
    name = [[NSMutableArray alloc] init];
    vicinity = [[NSMutableArray alloc] init];
    type = [[NSMutableArray alloc] init];
    longitude = [[NSMutableArray alloc] init];
    latitude = [[NSMutableArray alloc] init];
    iconurl = [[NSMutableArray alloc] init];
    spotName = [[NSMutableArray alloc] init];
    spotVicinity = [[NSMutableArray alloc] init];
    spotType = [[NSMutableArray alloc] init];
    spotLongitude = [[NSMutableArray alloc] init];
    spotLatitude = [[NSMutableArray alloc] init];
    categoryCount=[[NSMutableArray alloc]init];
    reference=[[NSMutableArray alloc]init];
    NSLog(@"nsmutable alloc init for array");
    [self.view addSubview:activityIndicator];
    
    
    [self createdb];
  
	
}

- (void)viewDidUnload
{
    NSLog(@"view did unload");
    [self setMapview:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");
    self.navigationController.navigationBar.hidden=YES;
    [self currentlocation];
    
    
    
    [self.view addSubview:activityIndicator]; 

    [self databaseRead];
    NSLog(@"database read from view will appear");
    
    [self mapannotion];
    NSLog(@"map annotation from view will appear");
    
    circumSpiceListViewController *viewController2 = [[circumSpiceListViewController alloc] initWithNibName:@"circumSpiceListViewController" bundle:nil];
    
    [viewController2 setValue:name];
    [viewController2 setVicinity:vicinity];
    [viewController2 setLatitude:latitude];
    [viewController2 setLongitude:longitude];
    [viewController2 setType:type];
    
    NSLog(@"calling objects of list view");
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
       NSLog(@"view did appear");
    
    [super viewDidAppear:animated];

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    int i;
    MKPointAnnotation *annot=(MKPointAnnotation *)view.annotation;
    NSLog(@"///////%@",[annot title]);
    for(i=0;i<[name count];i++)        {
        
        
        if([[annot title] isEqualToString:[name objectAtIndex:i]])
        {
            tagid=i;
            //NSLog(@"--->%d---->%@",i,[sender title]);
            
        }
        
        
    }
    

    circumSpiceDetailViewController *viewController4 = [[circumSpiceDetailViewController alloc] initWithNibName:@"circumSpiceDetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController4 animated:YES]; 
    NSLog(@"calling objects of list view by annotaion click");
    NSLog(@"spot name in callout %@",spotName);
    [viewController4 stringName:[spotName objectAtIndex:tagid] :tagid];
    [viewController4 stringVicinity:[spotVicinity objectAtIndex:tagid]:tagid];
    
    [viewController4 stringLatitude:[spotLatitude objectAtIndex:tagid]:tagid];
    [viewController4 stringLongitude:[spotLongitude objectAtIndex:tagid]:tagid];
    [viewController4 stringType:[spotType objectAtIndex:tagid]:tagid];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"view will dissapear");
        //[self.view reloadInputViews];
    self.navigationController.navigationBar.hidden=NO;
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"view did disappear");
    [spotName removeAllObjects];
    [name removeAllObjects];
    [spotLatitude removeAllObjects];
    [latitude removeAllObjects];
    [spotLongitude removeAllObjects];
    [longitude removeAllObjects];
    [spotVicinity removeAllObjects];
    [vicinity removeAllObjects];
    [spotType removeAllObjects];
    [type removeAllObjects];
    [reference removeAllObjects];
    [mapview removeAnnotations:mapview.annotations];
NSLog(@"removed objects from array in view did disappear");
    [self.view reloadInputViews];
    	[super viewDidDisappear:animated];
    NSLog(@"%@",categoryCount);
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
        currentReference=[[NSMutableString alloc] init];        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if ([currentElement isEqualToString:@"name"])
    { [currentName appendString:string]; 
    } else if ([currentElement isEqualToString:@"vicinity"])
    { [currentVicinity appendString:string];
    } else if ([currentElement isEqualToString:@"type"])
    { [currentType appendString:string];
    } else if ([currentElement isEqualToString:@"icon"])
    { [currentIconUrl appendString:string];
    } else if ([currentElement isEqualToString:@"lat"])
    { [currentLatitude appendString:string];
    } else if ([currentElement isEqualToString:@"lng"]) 
    { [currentLongitude appendString:string]; 
    } else if ([currentElement isEqualToString:@"reference"]) 
    { [currentReference appendString:string]; 
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
      //  data[index1]=currentTitle;
        NSLog(@"%@",currentReference);
        index1++;
        
        
    }
    spotName=name;
    counts=index1;
    
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

