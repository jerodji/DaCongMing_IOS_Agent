//
//  NSObject+Null.h
//  UnicornTV
//
//  Created by JerodJi on 2017/12/4.
//  Copyright © 2017年 Droi. All rights reserved.
//

/**
 nil：指向一个对象的空指针
 Nil：指向一个类的空指针
 NULL：指向其他类型（如：基本类型、C类型）的空指针
 NSNull：通常表示集合中的空值
 
 */



#import <Foundation/Foundation.h>

@interface NSObject (isNull)

BOOL IsNull(id obj);
BOOL NotNull(id obj);

+ (BOOL)isNull:(id)objc;
+ (BOOL)notNull:(id)objc;

+ (BOOL)isEmpty:(id)objc;

@end
