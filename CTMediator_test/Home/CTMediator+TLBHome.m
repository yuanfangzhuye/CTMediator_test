//
//  CTMediator+TLBHome.m
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import "CTMediator+TLBHome.h"

@implementation CTMediator (TLBHome)

- (UIViewController *)CTMediator_homeViewController:(NSDictionary *)params {
    return [self performTarget:@"HomeViewController" action:@"testHome" params:params shouldCacheTarget:NO];
}

@end
