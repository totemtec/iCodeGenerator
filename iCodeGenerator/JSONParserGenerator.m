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

+ (NSString*)parseProperties:(NSString*)name forType:(NSString*)type
{
    //    NSLog(@"type=%@, name=%@", type, name);
    
    NSString *translateString = nil;
    
    NSLog(@"%@=%@", name, type);
    
    if([@"NSString" isEqualToString:type] || [@"NSDictionary" isEqualToString:type])
    {
        
    }
    else if([@"NSArray" isEqualToString:type])
    {
        
    }
    else if([@"c" isEqualToString:type])
    {
        translateString = @"boolValue";
    }
    else if([@"i" isEqualToString:type])
    {
        translateString = @"intValue";
    }
    else if([@"f" isEqualToString:type])
    {
        translateString = @"floatValue";
    }
    else if([@"d" isEqualToString:type])
    {
        translateString = @"doubleValue";
    }
    else if([@"I" isEqualToString:type])
    {
        translateString = @"unsignedIntValue";
    }
    else if([@"l" isEqualToString:type])
    {
        translateString = @"longValue";
    }
    else if([@"L" isEqualToString:type])
    {
        translateString = @"unsignedLongValue";
    }
    else if([@"q" isEqualToString:type])
    {
        translateString = @"longLongValue";
    }
    else if([@"Q" isEqualToString:type])
    {
        translateString = @"unsignedLongLongValue";
    }
    else if([@"l" isEqualToString:type])
    {
        translateString = @"longValue";
    }
    else if([@"l" isEqualToString:type])
    {
        translateString = @"longValue";
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
    
    NSDictionary *properties = [ObjectRuntime classPropertiesFor:clazz];
    for (NSString *key in properties)
    {
        NSString *type = [properties objectForKey:key];
        [result appendString:[[self class] parseProperties:key forType:type]];
    }
    
    
    [result appendString:@"    }\n"];
    [result appendString:@"    return self;\n"];
    
    [result appendString:@"}"];
    
    NSLog(@"%@", result);
    
    return result;
}

@end
