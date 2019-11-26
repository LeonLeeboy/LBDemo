//
//  EHIUpdateAPPViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIUpdateAPPViewController.h"

static CGFloat kAnimationDuration() {
    return 0.3;
}

@interface EHIUpdateAPPViewController ()

@property (nonatomic, strong) EHIUpdateAppContentView *contentView;

@end

@implementation EHIUpdateAPPViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =kEHIHexColor_FFFFFF;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
     [self setupSubViews];
    
    [self p_showAnimation];
}

- (void)setupSubViews {
    EHIUpdateAppContentView *contentView = [[EHIUpdateAppContentView alloc] initWithUpdateWay:self.updateWay];
    EHiWeakSelf(self)
    contentView.nextTimeAction = ^{
        EHiStrongSelf(self)
        [self doNextTimeAction];
        NSLog(@"下次再说");
    };
    contentView.updateNowAction = ^{
        EHiStrongSelf(self)
        [self doNowUpdateAciton];
        NSLog(@"立即更新");
    };
    NSArray *tips = @[
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      @"【优化】自助取车方式优化，无需扫码快速取车。",
                      ];
    [contentView renderViewWithTips:tips];
    
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(contentView.superview);
    }];

    self.contentView = contentView;
    self.contentView.alpha = 0;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"----1");
        
//    [self performSelector:@selector(test) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:NSDate.date];
//        [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
        //        [[NSRunLoop currentRunLoop] run];
        NSLog(@"-----3");
    });
}

#pragma mark - Action
- (void)doNowUpdateAciton {
   
    [self p_dismiss];
}

- (void)test{
    NSLog(@"2");
}

- (void)doNextTimeAction {
    [self p_dismiss];
}

- (void)p_dismiss {
    
    [UIView animateWithDuration:kAnimationDuration() animations:^{
        self.view.alpha = 0;
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
         [self dismissViewControllerAnimated:NO completion:nil];
     }];
   
}

- (void)p_showAnimation {
    /// 背景
//    // 缩放动画
//    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//
//    NSMutableArray* values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    frameAnimation.values = values;
//
//    [self.view.layer addAnimation:frameAnimation forKey:nil];
    
    // 渐变色动画
    CABasicAnimation *backGroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backGroundColorAnimation.duration = kAnimationDuration();
    backGroundColorAnimation.fromValue = (id)[kEHIHexColor_000000 colorWithAlphaComponent:0].CGColor;
    backGroundColorAnimation.toValue = (id)[kEHIHexColor_000000 colorWithAlphaComponent:0.6].CGColor;
    backGroundColorAnimation.repeatCount = 1;
    backGroundColorAnimation.removedOnCompletion = NO;
    backGroundColorAnimation.fillMode = kCAFillModeForwards;
    
    [self.view.layer addAnimation:backGroundColorAnimation forKey:@"backGroundColorAnimation"];
    
    /// content
    [UIView animateWithDuration:kAnimationDuration() animations:^{
        self.contentView.alpha = 1;
    }];
    
}



@end
