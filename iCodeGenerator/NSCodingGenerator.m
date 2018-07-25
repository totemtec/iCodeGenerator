//
//  NSCodingGenerator.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/27/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "NSCodingGenerator.h"
#import "ObjectRuntime.h"

@implementation NSCodingGenerator

+ (NSString*)decodeIvar:(NSString*)name withType:(NSString*)type
{
    //    NSLog(@"type=%@, name=%@", type, name);
    
    NSString *typeString = @"Object";
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
            typeString = @"Int";
            break;
        case 'i':
            typeString = @"Int";
            break;
        case 'f':
            typeString = @"Float";
            break;
        case 'd':
            typeString = @"Double";
            break;
        case 'c':   // char, but the BOOL is char
            typeString = @"Bool";
            break;
            //        case 'c':   // char, but the BOOL is char
            //            typeString = @"charValue";
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
        result = [NSString stringWithFormat:@"        self.%@ = [[decoder decode%@ForKey:@\"%@\"] %@];\n", name, typeString, name, translateString];
    }
    else
    {
        result = [NSString stringWithFormat:@"        self.%@ = [decoder decode%@ForKey:@\"%@\"];\n", name, typeString, name];
    }
    
    
    return result;
}

+ (NSString*)encodeIvar:(NSString*)name withType:(NSString*)type
{
    //    NSLog(@"type=%@, name=%@", type, name);
    
    NSString *typeString = @"Object";
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
            typeString = @"Int";
            break;
        case 'i':
            typeString = @"Int";
            break;
        case 'f':
            typeString = @"Float";
            break;
        case 'd':
            typeString = @"Double";
            break;
        case 'c':   // char, but the BOOL is char
            typeString = @"Bool";
            break;
            //        case 'c':   // char, but the BOOL is char
            //            typeString = @"Object:[NSNumber numberWithChar";
            //            break;
        case 'C':   // unsigned char
            typeString = @"Object:[NSNumber numberWithUnsignedChar";
            break;
        case 'I':   // unsigned int
            typeString = @"Object:[NSNumber numberWithUnsignedInt";
            break;
        case 's':   // short
            typeString = @"Object:[NSNumber numberWithShort";
            break;
        case 'S':   // unsigned short
            typeString = @"Object:[NSNumber numberWithUnsignedShort";
            break;
        case 'l':   // long
            typeString = @"Object:[NSNumber numberWithLong";
            break;
        case 'L':   // unsigned long
            typeString = @"Object:[NSNumber numberWithUnsignedLong";
            break;
        case 'q':   // long long
            typeString = @"Object:[NSNumber numberWithLongLong";
            break;
        case 'Q':   // unsigned long long
            typeString = @"Object:[NSNumber numberWithUnsignedLongLong";
            break;
    }
    
    NSString *result;
    if ([typeString rangeOfString:@"["].location == NSNotFound)
    {
        result = [NSString stringWithFormat:@"        [encoder encode%@:self.%@ forKey:@\"%@\"];\n", typeString, name, name];
    }
    else
    {
        result = [NSString stringWithFormat:@"        [encoder encode%@:self.%@] forKey:@\"%@\"];\n", typeString, name, name];
    }
    
    return result;
}


+ (NSString*)encodeForClass:(Class)clazz
{
    NSMutableString *result = [NSMutableString stringWithString:@"\n- (void)encodeWithCoder:(NSCoder*)encoder\n"];
    [result appendString:@"{\n"];
    
    
    NSDictionary *ivarDict = [ObjectRuntime classPropertiesFor:clazz];
    for (NSString *key in ivarDict)
    {
        NSString *type = [ivarDict objectForKey:key];
        
        [result appendString:[[self class] encodeIvar:key withType:type]];
    }
    
    [result appendString:@"}\n"];
    
    return result;
}

+ (NSString*)decodeForClass:(Class)clazz
{
    NSMutableString *result = [NSMutableString stringWithString:@"\n- (id)initWithCoder:(NSCoder*)decoder\n"];
    [result appendString:@"{\n"];
    [result appendString:@"    self = [super init];\n"];
    [result appendString:@"    if (self)\n"];
    [result appendString:@"    {\n"];
    
    NSDictionary *ivarDict = [ObjectRuntime classPropertiesFor:clazz];
    for (NSString *key in ivarDict)
    {
        NSString *type = [ivarDict objectForKey:key];
        
		[result appendString:[[self class] decodeIvar:key withType:type]];
    }
    
    
    [result appendString:@"    }\n"];
    [result appendString:@"    return self;\n"];
    
    [result appendString:@"}"];
    
    NSLog(@"%@", result);
    
    return result;
}



@end
