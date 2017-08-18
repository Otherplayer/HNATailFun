//
//  ViewController.m
//  APPLEKnowledgeRecorder
//
//  Created by __无邪_ on 2017/7/12.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "APPLEKnowledgeRecorder-Swift.h"

@interface ViewController ()

@end

@implementation ViewController
static long count = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testInvocation];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gotoSubController:(id)sender {
    SwiftController *controller = [[SwiftController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - NSInvocation

- (long long)fibonacci_indirect:(NSInteger)n{
    if (n < 1) {
        return 0;
    }
    if (n < 2) {
        return 1;
    }
    return  [self fibonacci_indirect:n - 1] + [self fibonacci_indirect:n - 2];
}

- (long long)fibonacci_tail:(NSInteger)n ac1:(NSInteger)ac1 ac2:(NSInteger)ac2{
    if (n < 1) {return 0;}
    if (n < 2) {return ac2;}
    return [self fibonacci_tail:n - 1 ac1:ac2 ac2:ac1 + ac2];
}

- (void)testInvocation{
    // NSInvocation中保存了方法所属的对象/方法名称/参数/返回值,其实NSInvocation就是将一个方法变成一个对象
    SEL selector = NSSelectorFromString(@"run:");
    NSMethodSignature  *signature = [ViewController instanceMethodSignatureForSelector:selector];
    //此时我们应该判断方法是否存在，如果不存在这抛出异常
    if (signature == nil) {
        //aSelector为传进来的方法
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(selector)];
        [NSException raise:@"方法调用出现异常" format:info, nil];
    }
    //此处不能通过遍历参数数组来设置参数，因为外界传进来的参数个数是不可控的
    //因此通过numberOfArguments方法获取的参数个数,是包含self和_cmd的，然后比较方法需要的参数和外界传进来的参数个数，并且取它们之间的最小值
    NSUInteger argsCount = signature.numberOfArguments - 2;
    //2、创建NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置方法调用者
    invocation.target = self;
    //注意：这里的方法名一定要与方法签名类中的方法一致
    invocation.selector = @selector(run:);
    
    NSArray *objects = @[@"aaa"];
    NSInteger count = MIN(argsCount, objects.count);
    for (int i = 0; i < count; i++) {
        id obj = objects[i];
        // 判断需要设置的参数是否是NSNull, 如果是就设置为nil
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        //这里的Index要从2开始，以为0跟1已经被占据了，分别是self（target）,selector(_cmd)
        [invocation setArgument:&obj atIndex:i + 2];
    }
    //3、调用invoke方法
    [invocation invoke];
    // 返回值
    id res = nil;
    if (signature.methodReturnLength != 0) {//有返回值
        //将返回值赋值给res
        [invocation getReturnValue:&res];
    }
    NSLog(@"%@",res);
}
//实现run:方法
- (NSString *)run:(NSString *)method{
    NSLog(@"%s",__func__);
    return method;
}
@end
