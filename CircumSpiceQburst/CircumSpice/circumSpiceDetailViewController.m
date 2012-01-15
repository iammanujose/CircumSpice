//
//  circumSpiceDetailViewController.m
//  CircumSpice
//
//  Created by user on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "circumSpiceDetailViewController.h"

static int count;
@implementation circumSpiceDetailViewController

@synthesize detailName,detailType,detailLatitude,detailLongitude,detailVicinity;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    parserData =[[NSMutableArray alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CircumSpiceXmlParser *viewController5 = [CircumSpiceXmlParser alloc] ;
    parserData=[viewController5 xmlparser:@"CnRqAAAAJfLK4-o8qnZnA7J4dafkRDVk3k9qNJz4DAEXQSaEtp_pefwBECGgjUWoPDAeeNfN_NdTKjYIs216B8EJT6Q3Rofx1OYTWzNA7HSHtgza2VKQkMCqPZvwjQDIl5JtyLGf44CjTbUtWQz_UGbJJoxYuBIQm0g8jg5tWMZbiDKUjdsZqhoUqjJ_6KrFj7hi62TXW9jOrRV6zW8"];
    NSLog(@"hiiii%@",parserData);
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
- (void) stringName: (NSString *) string:(NSInteger )index
{
    //NSLog(@"%@",string);
    detailName.text=string;
    
}
- (void) stringVicinity: (NSString *) string:(NSInteger )index
{
  //   NSLog(@"%@",string);
    detailVicinity.text=string;
    
}
- (void) stringLongitude:(NSString *)string :(NSInteger)index
{
//    NSLog(@"%@",string);
    detailLongitude.text=string;
    
}
- (void) stringLatitude:(NSString *)string :(NSInteger)index
{
    //NSLog(@"%@",string);
    detailLatitude.text=string;
    
}
- (void) stringType:(NSString *)string :(NSInteger)index
{
    //NSLog(@"%@",string);
    detailType.text=string;
    
}


-(void)count:(int)cnt
{
   // NSLog(@"%d",cnt);
    count=cnt;
    
}
-(void)setNameDetail:(NSMutableArray*)array
{

   // NSLog(@"%@",array);
    
    
}
//- (void) stringLongitude:(NSString *)string1
//{
//     NSLog(@"%@",string1);
//    detailLongitude.text=string1;
//    
//}
//- (void) stringLatitude:(NSString *) string
//{
//     NSLog(@"%@",string);
//    detailLatitude.text=string;
//    
//}
//- (void) stringType:(NSString *) string
//{
//     NSLog(@"%@",string);
//    detailType.text=string;
//    
//}


@end
