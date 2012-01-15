//
//  CircumSpiceXmlParser.m
//  CircumSpice
//
//  Created by Manu on 15/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircumSpiceXmlParser.h"

@implementation CircumSpiceXmlParser
-(NSMutableArray *) xmlparser:(NSString *)referenceKey;
{
    //int i;
    parserData =[[NSMutableArray alloc]init];
    NSString *urls=[[NSString alloc]initWithFormat:@"https://maps.googleapis.com/maps/api/place/details/xml?reference=%@&sensor=true&key=AIzaSyBNa8_9X2uUQh7y1ee85w1jbltBOK_kOE0",referenceKey];
    NSURL *url = [[NSURL alloc] initWithString:urls];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    BOOL success =[xmlParser parse];
    
    if(!success)
        
        NSLog(@"Error Error Error!!!");
   
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    return parserData;
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName 
     attributes:(NSDictionary *)attributeDict{
    currentElement = [elementName copy];
    if ([elementName isEqualToString:@"result"])
    { // clear out our story item caches... 
        
        //item = [[NSMutableDictionary alloc] init];
        currentAddress = [[NSMutableString alloc] init];
        currentPhoneNumber= [[NSMutableString alloc] init];
        internationalPhone= [[NSMutableString alloc] init];
               
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if ([currentElement isEqualToString:@"formatted_phone_number"])
    { [currentPhoneNumber appendString:string]; 
    } else if ([currentElement isEqualToString:@"formatted_address"])
    { [currentAddress appendString:string];
    } else if ([currentElement isEqualToString:@"international_phone_number"])
    { [internationalPhone appendString:string];
    
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"result"]) {
        
        NSString *addressWithoutSpaces = [currentAddress stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        NSString *phoneWithoutSpaces = [currentPhoneNumber stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
        NSString *internationalPhoneWithoutSpaces = [internationalPhone stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString *latitudeWithoutSpaces = [currentLatitude stringByReplacingOccurrencesOfString:@"\n    " withString:@""];
//        NSString *longitudeWithoutSpaces = [currentLongitude stringByReplacingOccurrencesOfString:@"\n   \n  \n  " withString:@""];
//        NSString *iconUrlWithoutSpaces = [currentIconUrl stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
//        [name addObject:nameWithoutSpaces];
//        [vicinity addObject:vicinityWithoutSpaces];
//        
//        [type addObject:typeWithoutSpaces];
//        [latitude addObject:latitudeWithoutSpaces ];
//        [longitude addObject:longitudeWithoutSpaces];
//        [iconurl addObject:iconUrlWithoutSpaces];
//        //  data[index1]=currentTitle;
//        NSLog(@"%@",currentReference);
//        index1++;
        [parserData insertObject:addressWithoutSpaces atIndex:0];
        [parserData insertObject:phoneWithoutSpaces atIndex:1];
        [parserData insertObject:internationalPhoneWithoutSpaces atIndex:2];
    }
   
    //currentElementValue = nil;
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
   // NSLog(@"parser data%@",parserData);
}

@end
