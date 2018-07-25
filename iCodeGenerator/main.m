//
//  main.m
//  iCodeGenerator
//
//  Created by majianglin on 2018/7/25.
//  Copyright © 2018 Totem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCodingGenerator.h"
#import "JSONParserGenerator.h"
#import "PropertiesGenerator.h"

#import "DataModel.h"
#import "HFCustomer.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Class clazz = [HFCustomer class];
        
        NSString *str = [PropertiesGenerator propertiesForClass:clazz];
        NSLog(@"%@", str);
        
//        NSString *str2 = [NSCodingGenerator decodeForClass:clazz];
//        NSLog(@"%@", str2);
//
//        NSString *str3 = [NSCodingGenerator encodeForClass:clazz];
//        NSLog(@"%@", str3);
        
        NSString *str4 = [JSONParserGenerator parserForClass:clazz];
        NSLog(@"%@", str4);
    }
    return 0;
}
