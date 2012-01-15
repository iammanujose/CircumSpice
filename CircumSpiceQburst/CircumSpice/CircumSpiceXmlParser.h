//
//  CircumSpiceXmlParser.h
//  CircumSpice
//
//  Created by Manu on 15/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircumSpiceXmlParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentPhoneNumber;
    NSMutableString *currentAddress;
    NSMutableString *internationalPhone;
    NSString * currentElement;
    NSMutableArray *parserData;
}
-(NSMutableArray *) xmlparser:(NSString *)referenceKey;

@end
