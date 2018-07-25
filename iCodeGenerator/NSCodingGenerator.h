//
//  NSCodingGenerator.h
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/27/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCodingGenerator : NSObject

+ (NSString*)decodeForClass:(Class)clazz;

+ (NSString*)encodeForClass:(Class)clazz;

@end
