//
//  AppDelegate.m
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/27/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import "AppDelegate.h"
#import "DataModel.h"
#import "NSCodingGenerator.h"
#import "HFCustomer.h"
#import "JSONParserGenerator.h"
#import "PropertiesGenerator.h"

@implementation AppDelegate

- (void)autoGenerateCodeForClass:(Class)clazz
{
    NSString *str = [PropertiesGenerator propertiesForClass:clazz];
    NSLog(@"%@", str);
    
    NSString *str2 = [NSCodingGenerator decodeForClass:clazz];
    NSLog(@"%@", str2);
    
    NSString *str3 = [NSCodingGenerator encodeForClass:clazz];
    NSLog(@"%@", str3);
    
    NSString *str4 = [JSONParserGenerator parserForClass:clazz];
    NSLog(@"%@", str4);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // for Test
    //[self autoGenerateCodeForClass:[DataModel class]];
    

    // for production
    [self autoGenerateCodeForClass:[HFCustomer class]];
    
    return YES;
}

@end
