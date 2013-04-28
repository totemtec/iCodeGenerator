//
//  DataModel.h
//  NSCodingGenerator
//
//  Created by Ma Jianglin on 4/27/13.
//  Copyright (c) 2013 Ma Jianglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomObject : NSObject

@end

@interface DataModel : NSObject
{
    //常用的类型
    int intValue;
    BOOL boolValue;
    double doubleValue;
    float floatValue;
    NSString *stringValue;
    NSArray *arrayValue;
    NSDictionary *dictValue;
    CustomObject *customObject;
    
    //C或者C++中的布尔型
    _Bool boolValue2;
    bool boolValue3;
    
    //其他一些不常用的类型
    char testChar;
    unsigned char testUnsignedChar;
    short testShort;
    unsigned short unsignedShortValue;
    unsigned int unsignedIntValue;
    long longValue;
    unsigned long unsignedLongValue;
    long long longLongValue;
    unsigned long long unsignedLongLongValue;
}



@end
