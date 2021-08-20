//
//  ViewController.m
//  CTMediator_test
//
//  Created by lab team on 2021/8/20.
//

#import "ViewController.h"
#import "CTMediator+TLBHome.h"
#import "DictionaryModelUtil.h"
#import "EncodeDecodeUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
}

// 组件化
- (void)btnclick1 {
    UIViewController *vc = [[CTMediator sharedInstance] CTMediator_homeViewController:@{@"param1":@"参数1", @"param2":@"参数2"}];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

// 模型-字典
- (void)btnClick2 {
    /**字典转模型*/
    DictionaryModelUtil *model = [[DictionaryModelUtil alloc] init];
    NSDictionary *dict = @{
        @"username":@"lichao",
        @"passpoet":@"qwert",
        @"age":@(30),
        @"height":@(180),
        @"tlabDictionary":@{@"test":@"123"},
        @"tlabArray":@[@"1", @"2"]
    };
    [model ditionaryToModel:dict];
    NSLog(@"%@", model);
    
    /**模型转字典*/
//    DictionaryModelUtil *model = [[DictionaryModelUtil alloc] init];
//    model.username = @"lichao";
//    model.passpoet = @"1332323";
//    model.age = @(30);
//    model.height = @(180);
//    model.tlabDictionary = @{@"test":@"123"};
//    model.tlabArray = @[@"1", @"2"];
//
//    NSLog(@"%@", [model modelToDictionary]);
}

- (void)btnClick3 {
    EncodeDecodeUtil *model = [[EncodeDecodeUtil alloc] init];
    model.username = @"lc";
    model.age = @(30);
    model.nickname = @"tlab";
    
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"archive.plist"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:nil];
    [data writeToFile:filename atomically:YES];
    
    NSData *data2 = [[NSData alloc] initWithContentsOfFile:filename];
    EncodeDecodeUtil *model2 = [NSKeyedUnarchiver unarchivedObjectOfClass:[EncodeDecodeUtil class] fromData:data2 error:nil];
    NSLog(@"%@-%@-%@", model2.username, model.age, model.nickname);
}


@end
