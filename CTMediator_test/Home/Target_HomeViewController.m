//
//  Target_HomeViewController.m
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import "Target_HomeViewController.h"
#import "HomeViewController.h"

@implementation Target_HomeViewController

- (UIViewController *)Action_testHome:(NSDictionary *)params {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.param1 = params[@"param1"];
    homeVC.param2 = params[@"param2"];
    return homeVC;
}

@end
