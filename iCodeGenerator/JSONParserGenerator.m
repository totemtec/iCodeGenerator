//
//  JSONParserGenerator.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/28/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "JSONParserGenerator.h"
#import "ObjectRuntime.h"

@implementation JSONParserGenerator

+ (NSString*)parseIvar:(NSString*)name withType:(NSString*)type
{
    //    NSLog(@"type=%@, name=%@", type, name);
    
    NSString *translateString = nil;
    
    switch ([type characterAtIndex:0])
    {
        case '@':   // object
            if ([[type componentsSeparatedByString:@"\""] count] > 1)
            {
                NSString *className = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
                Class class = NSClassFromString(className);
                if ([class isSubclassOfClass:[NSString class]]
                    || [class isSubclassOfClass:[NSArray class]]
                    || [class isSubclassOfClass:[NSDictionary class]])
                {
                    //do nothing
                }
                else
                {
                    
                }
            }
            break;
        case 'B':   //_Bool or bool in C/C++
            translateString = @"intValue";
            break;
        case 'i':
            translateString = @"intValue";
            break;
        case 'f':
            translateString = @"floatValue";
            break;
        case 'd':
            translateString = @"doubleValue";
            break;
        case 'c':   // char, but the BOOL is char
            translateString = @"boolValue";
            break;
//        case 'c':   // char, but the BOOL is char
//            translateString = @"charValue";
//            break;
        case 'C':   // unsigned char
            translateString = @"unsignedCharValue";
            break;
        case 'I':   // unsigned int
            translateString = @"unsignedIntValue";
            break;
        case 's':   // short
            translateString = @"shortValue";
            break;
        case 'S':   // unsigned short
            translateString = @"unsignedShortValue";
            break;
        case 'l':   // long
            translateString = @"longValue";
            break;
        case 'L':   // unsigned long
            translateString = @"unsignedLongValue";
            break;
        case 'q':   // long long
            translateString = @"longLongValue";
            break;
        case 'Q':   // unsigned long long
            translateString = @"unsignedLongLongValue";
            break;
    }
    
    NSString *result;
    
    
    if (translateString)
    {
        result = [NSString stringWithFormat:@"        self.%@ = [[dict objectForKey:@\"%@\"] %@];\n", name, name, translateString];
    }
    else
    {
        result = [NSString stringWithFormat:@"        self.%@ = [dict objectForKey:@\"%@\"];\n", name, name];
    }
    
    
    return result;
}

+ (NSString*)parserForClass:(Class)clazz
{
    NSMutableString *result = [NSMutableString stringWithString:@"\n- (id)initWithDictionary:(NSDictionary*)dict\n"];
    [result appendString:@"{\n"];
    [result appendString:@"    self = [super init];\n"];
    [result appendString:@"    if (self)\n"];
    [result appendString:@"    {\n"];
    
    NSDictionary *ivarDict = [ObjectRuntime ivarForClass:clazz];
    for (NSString *key in ivarDict)
    {
        NSString *type = [ivarDict objectForKey:key];
        
		[result appendString:[[self class] parseIvar:key withType:type]];
    }
    
    
    [result appendString:@"    }\n"];
    [result appendString:@"    return self;\n"];
    
    [result appendString:@"}"];
    
    NSLog(@"%@", result);
    
    return result;
}

@end
