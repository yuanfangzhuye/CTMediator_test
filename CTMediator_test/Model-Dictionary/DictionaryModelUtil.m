//
//  DictionaryModelUtil.m
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import "DictionaryModelUtil.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation DictionaryModelUtil

// 字典转模型
- (instancetype)ditionaryToModel:(NSDictionary *)dictionary {
    NSArray *keyAray = [dictionary allKeys];
    for (int i = 0; i < keyAray.count; i++) {
        NSString *key = keyAray[i];
        id value = [dictionary valueForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
            value = [self arrayOrDictionaryWithObject:value];
        }
        
        // 调用set方法
        NSString *setNameMethod = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
        SEL selector = NSSelectorFromString(setNameMethod);
        if ([self respondsToSelector:selector]) {
            ((void (*)(id, SEL, id))(void *)objc_msgSend)(self, selector, value);
        }
        else {
            NSLog(@"生成%@set方法失败", key.capitalizedString);
        }
    }

    return self;
}

- (id)arrayOrDictionaryWithObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSObject *obj in object) {
            if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                [mutableArray addObject:[self arrayOrDictionaryWithObject:obj]];
            }
            else if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [mutableArray addObject:obj];
            }
            else {
                [mutableArray addObject:[self modelToDictionary]];
            }
        }
        
        return [mutableArray copy];
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)object;
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *key in dict.allKeys) {
            id obj = [dict objectForKey:key];
            if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                [mutableDictionary setObject:[self arrayOrDictionaryWithObject:obj] forKey:key];
            }
            else if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [mutableDictionary setObject:obj forKey:key];
            }
            else {
                [mutableDictionary setObject:[self modelToDictionary] forKey:key];
            }
        }
        
        return [mutableDictionary copy];
    }
    
    return [NSNull null];
}

// 模型转字典
- (NSDictionary *)modelToDictionary {
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t propertyT = propertyList[i];
        const char *propertyName = property_getName(propertyT);
        NSString *name = [NSString stringWithUTF8String:propertyName];

        // 调用get方法
        SEL selector = NSSelectorFromString(name);
        if ([self respondsToSelector:selector]) {
            id value = ((id (*)(id, SEL))(void *)objc_msgSend)(self, selector);
            [mutableDictionary setValue:value forKey:name];
        }
        else {
            NSLog(@"没找到该属性%@",name);
        }
    }
    free(propertyList);
    return [mutableDictionary copy];
}

@end
