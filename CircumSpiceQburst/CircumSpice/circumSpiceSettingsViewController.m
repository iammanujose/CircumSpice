//
//  circumSpiceSettingsViewController.m
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "circumSpiceSettingsViewController.h"
#import "circumSpiceMapViewController.h"

static int switchData[6];
@implementation circumSpiceSettingsViewController
static sqlite3_stmt *addStmt = nil;

@synthesize spotSelector;

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
-(void)insertIntoDb
{
    
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *contactDB;
    
    // Get the documents directory.
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    docsDir = [dirPaths objectAtIndex:0];    
    
    // Build the path to the database file.
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"mapdata.sqlite"]];
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        
        if(addStmt == nil) {
            const char *sql = "replace into options(rowid, school, atm, hospital, post, bank,bar) Values(1,?, ?, ?, ?, ?, ?)";
            if(sqlite3_prepare_v2(contactDB, sql, -1, &addStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(contactDB));
        }
        
        for(int i=1;i<=6;i++){
            
            //  sqlite3_bind_text(addStmt, i-1,"1" , -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(addStmt, i,switchData[i-1]);            
        }
        
        if(SQLITE_DONE != sqlite3_step(addStmt))
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(contactDB));
        else
        {   
            
            sqlite3_reset(addStmt);
        }
        
    }
    
    
    
    else {
        
        NSLog(@"Failed to open database");
        
    }   
    
}    


- (void)viewWillDisappear:(BOOL)animated
{
    
    //[self insertIntoDb];
    
    //circumSpiceMapViewController *viewController1=[[circumSpiceMapViewController alloc]initWithNibName:@"circumSpiceMapViewController" bundle:nil];
    
    
    
	[super viewWillDisappear:animated];
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

-(IBAction)selectSpot:(id)sender
{
    UISwitch *spotSelect=(UISwitch *)sender;
  if(spotSelect.on)
  {
   if([sender tag]==0)
   {
            
       switchData[0]=1; 
       NSLog(@"first");
   }
    
    else if([sender tag]==1)
    {
        switchData[1]=1;
        NSLog(@"second");
    }
    
    else if([sender tag]==2)
    {
        switchData[2]=1;
        NSLog(@"third");
    }
    else if([sender tag]==3)
    {
        
      switchData[3]=1;  
        NSLog(@"fourth");
        
    }
    
    else if([sender tag]==4)
    {
       switchData[4]=1;
        NSLog(@"fifth");
        
    }
    
    else if([sender tag]==5)
    {
        
       switchData[5]=1;
        NSLog(@"sixth");
    }
  }
    else
    {
        if([sender tag]==0)
        {
            
            switchData[0]=0; 
            NSLog(@"first");
        }
        
        else if([sender tag]==1)
        {
            switchData[1]=0;
            NSLog(@"second");
        }
        
        else if([sender tag]==2)
        {
            switchData[2]=0;
            NSLog(@"third");
        }
        else if([sender tag]==3)
        {
            
            switchData[3]=0;  
            NSLog(@"fourth");
            
        }
        
        else if([sender tag]==4)
        {
            switchData[4]=0;
            NSLog(@"fifth");
            
        }
        
        else if([sender tag]==5)
        {
            
            switchData[5]=0;
            NSLog(@"sixth");
        }
 
    }
    for(int i=0;i<6;i++)
    {
    NSLog(@"array--->%d",switchData[i]);
    }
    [self insertIntoDb];
    
}

@end
