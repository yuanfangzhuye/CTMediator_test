//
//  EncodeDecodeUtil.h
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncodeDecodeUtil : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSString *nickname;

@end

NS_ASSUME_NONNULL_END
