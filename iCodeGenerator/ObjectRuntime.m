//
//  ObjectRuntime.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/28/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "ObjectRuntime.h"
#import <objc/runtime.h>


@implementation ObjectRuntime

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}


+ (NSDictionary *)classPropertiesFor:(Class)clazz
{
    if (clazz == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

// Ref https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html

+ (NSDictionary*) typeDictionary
{
    NSDictionary *dict = @{@"c":@"char",
                           @"i":@"int",
                           @"s":@"short",
                           @"l":@"long",
                           @"q":@"long long",
                           @"C":@"unsigned char",
                           @"I":@"unsigned int",
                           @"S":@"unsigned short",
                           @"L":@"unsigned long",
                           @"Q":@"unsigned long long",
                           @"f":@"float",
                           @"d":@"double",
                           @"B":@"_Bool",
                           @"v":@"void",
                           @"*":@"char *",
                           @"@":@"id",
                           @"#":@"Class",
                           @":":@"SEL",
                           @"[array type]":@"NSArray",
                           @"{name=type...}":@"structure",
                           @"(name=type...)":@"union",
                           @"bnum":@"A bit field of num bits",
                           @"^type":@"指针",
                           @"?":@"unknown",
                           };
    return dict;
}


@end
