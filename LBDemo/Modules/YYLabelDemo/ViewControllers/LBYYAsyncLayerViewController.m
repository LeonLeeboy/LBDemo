//
//  LBYYAsyncLayerViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/11.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBYYAsyncLayerViewController.h"

@interface LBYYAsyncLayerViewController ()

@end

@implementation LBYYAsyncLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kLBAPPHexColor_FFFFFF;
    [self testAsyncLayer];

}

- (void)testAsyncLayer {
    YYLabel *lab = [[YYLabel alloc] init];
    lab.attributedText = [self p_getAttributedString];
    [self.view addSubview:lab];
}

#pragma mark - private
- (NSAttributedString *)p_getAttributedString  {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] initWithString:@"wasdff"];
    
    YYTextShadow *shadow = [[YYTextShadow alloc] init];
    shadow.offset = CGSizeMake(3, 3);
    rst.textShadow = shadow;
    
    return rst;
}
@end
