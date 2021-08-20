//
//  DictionaryModelUtil.h
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DictionaryModelUtil : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *passpoet;
@property (nonatomic, assign) NSNumber *age;
@property (nonatomic, assign) NSNumber *height;
@property (nonatomic, copy) NSDictionary *tlabDictionary;
@property (nonatomic, copy) NSArray *tlabArray;

- (instancetype)ditionaryToModel:(NSDictionary *)dictionary;
- (NSDictionary *)modelToDictionary;

@end

NS_ASSUME_NONNULL_END
