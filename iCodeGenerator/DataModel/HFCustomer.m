//
//  HFCustomer.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/28/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "HFCustomer.h"

@implementation HFCustomer

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.name = [dict objectForKey:@"name"];
        self.obj = [dict objectForKey:@"obj"];
        self.dict = [dict objectForKey:@"dict"];
        self.salaryFloat = [[dict objectForKey:@"salaryFloat"] floatValue];
        self.age = [[dict objectForKey:@"age"] intValue];
        self.children = [dict objectForKey:@"children"];
        self.parent = [dict objectForKey:@"parent"];
        self.customerId = [[dict objectForKey:@"customerId"] unsignedLongLongValue];
        self.isMan = [[dict objectForKey:@"isMan"] boolValue];
        self.salaryDouble = [[dict objectForKey:@"salaryDouble"] doubleValue];
        
        NSArray *childrenJson = [dict objectForKey:@"children"];
        if ([childrenJson count] > 0)
        {
            NSMutableArray *children = [NSMutableArray array];
            for (NSDictionary *dict in childrenJson)
            {
                [children addObject:[[HFCustomer alloc] initWithDictionary:dict]];
            }
            self.children = children;
        }
    }
    return self;
}

@end
