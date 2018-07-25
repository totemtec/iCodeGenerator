//
//  PropertiesGenerator.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/28/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "PropertiesGenerator.h"
#import "ObjectRuntime.h"

@implementation PropertiesGenerator

+ (NSString*)propertiesForClass:(Class)clazz
{
    NSMutableString *result = [NSMutableString stringWithString:@"\n"];
    NSDictionary *properties = [ObjectRuntime classPropertiesFor:clazz];
//    for (NSString *key in properties)
//    {
//        NSString *type = [properties objectForKey:key];
//
//        if ([type characterAtIndex:0] == '@')
//        {
//            [result appendFormat:@"@property (strong, nonatomic) %@ *%@;\n", [ObjectRuntime nameForType:type], key];
//        }
//        else
//        {
//            [result appendFormat:@"@property (nonatomic) %@ %@;\n", [ObjectRuntime nameForType:type], key];
//        }
//
//    }
    
    NSLog(@"%@", properties);
    
    return result;
}

@end
