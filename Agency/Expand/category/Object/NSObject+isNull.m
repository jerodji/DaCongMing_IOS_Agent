//
//  NSObject+Null.m
//  UnicornTV
//
//  Created by JerodJi on 2017/12/4.
//  Copyright © 2017年 Droi. All rights reserved.
//
/**
 "==" 是判断两个对象的引用（reference）是否一样，也就是内存地址是否一样。
 "isEqualTo" 判断是一个类方法，判断连个对象在类型和值上是否一样。
 
 因为使用[NSNull null]产生的实例都的内存地址都一样，所以可以使用"=="。
 */
#import "NSObject+isNull.h"

@implementation NSObject (isNull)

BOOL IsNull(id obj) {
    return [NSObject isNull:obj];
}

BOOL NotNull(id obj) {
    return [NSObject notNull:obj];
}

+ (BOOL)isNull:(id)objc
{
    if (nil==objc || [objc isEqual:[NSNull null]] || [objc isEqual:@"<null>"] || [objc isEqual:@"null"] || [objc isEqual:@"(null)"] ||  objc==Nil || objc==NULL || [objc isEqual:@"<nil>"])
    {
        return YES;
    }
    else
    {
        if ([self isEmpty:objc]) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)notNull:(id)objc
{
    return ![self isNull:objc];
}

+ (BOOL)isEmpty:(id)objc
{
    if ([objc isKindOfClass:[NSString class]]) {
        NSString* str = (NSString*)objc;
        if (str.length == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*)objc;
        if (array.count == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dic = (NSDictionary*)objc;
        if (dic.count == 0) {
            return YES;
        }
    }
    
    return NO;
}



@end
