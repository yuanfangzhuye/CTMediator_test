//
//  EncodeDecodeUtil.m
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import "EncodeDecodeUtil.h"
#import <objc/runtime.h>

@implementation EncodeDecodeUtil

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int count;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [coder decodeObjectOfClasses:[NSSet setWithObject:[self class]] forKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    
    return self;
}

@end
