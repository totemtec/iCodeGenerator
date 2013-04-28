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

+ (NSMutableDictionary*)ivarForClass:(Class)klass
{
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int varCount;
    
    Ivar *vars = class_copyIvarList(klass, &varCount);
    
    for (int i = 0; i < varCount; i++)
    {
        Ivar var = vars[i];
        
        const char* name = ivar_getName(var);
        const char* typeEncoding = ivar_getTypeEncoding(var);
        
        [results setObject:[NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding]
                    forKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
    }
    
    free(vars);
    
    return results;
}

+ (NSString*)nameForType:(NSString*)type
{
    NSString *name = @"id";
    switch ([type characterAtIndex:0])
    {
        case '@':   // object
            if ([[type componentsSeparatedByString:@"\""] count] > 1)
            {
                name = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
            }
            break;
        case 'B':   //_Bool or bool in C/C++
            name = @"_Bool";
            break;
        case 'i':
            name = @"int";
            break;
        case 'f':
            name = @"float";
            break;
        case 'd':
            name = @"double";
            break;
        case 'c':   // char, but the BOOL is char
            name = @"BOOL";
            break;
            //        case 'c':   // char, but the BOOL is char
            //            name = @"char";
            //            break;
        case 'C':   // unsigned char
            name = @"unsigned char";
            break;
        case 'I':   // unsigned int
            name = @"unsigned int";
            break;
        case 's':   // short
            name = @"short";
            break;
        case 'S':   // unsigned short
            name = @"unsigned short";
            break;
        case 'l':   // long
            name = @"long";
            break;
        case 'L':   // unsigned long
            name = @"unsigned long";
            break;
        case 'q':   // long long
            name = @"long long";
            break;
        case 'Q':   // unsigned long long
            name = @"unsigned long long";
            break;
    }
    
    return name;
}


@end
