//
//  HFCustomer.h
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/28/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomObject;

@interface HFCustomer : NSObject

@property(nonatomic) NSUInteger customerId;

@property(nonatomic) BOOL isMan;

@property(nonatomic) int age;

@property(nonatomic) float salaryFloat;

@property(nonatomic) double salaryDouble;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, copy) CustomObject *obj;

@property(nonatomic, strong) NSArray *children;

@property(nonatomic, strong) NSDictionary *dict;

@property(nonatomic, strong) id parent;


@end
