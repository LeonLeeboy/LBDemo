//
//  LBRunLoopViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBRunLoopViewController.h"
#import "LBRunLoopViewModel.h"

@interface LBRunLoopViewController ()

@property(strong, nonatomic) LBRunLoopViewModel *viewModel;

@end

@implementation LBRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
//    [self test];
//    [self.viewModel getData];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)dealloc {
    [self.viewModel destroyTimer];
    NSLog(@"dealloc -----------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self.viewModel stopTimer];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"hahahhahah ---------- hahahah %@",[NSDate date]);
//        [self.viewModel fireTimer];
//    });
    
    [self test];
}

- (void)asdfa {
    [[NSRunLoop currentRunLoop] run];
}

- (void)test {
    NSThread *th = [[NSThread alloc] initWithTarget:self selector:@selector(asdfa) object:nil];
     [self performSelector:@selector(test2) onThread:th withObject:nil waitUntilDone:YES];
    NSLog(@"da");
}

- (void)test2 {
    NSLog(@"2");
}


#pragma mark - Getter
- (LBRunLoopViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LBRunLoopViewModel alloc] init];
    }
    return _viewModel;
}


@end
