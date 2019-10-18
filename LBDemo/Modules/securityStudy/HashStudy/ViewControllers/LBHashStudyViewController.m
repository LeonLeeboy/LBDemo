//
//  LBHashStudyViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/10/17.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBHashStudyViewController.h"

@interface LBHashStudyViewController ()

@end

@implementation LBHashStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"hash Study";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

static NSString *salt = @"asfdl;&4)34855%$#@";

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 用户名密码不需要保存到客户端
    NSString *pwd = @"123456";
//    // 加盐 (一旦泄露不好)
//    pwd = [pwd stringByAppendingString:salt];
//    NSString *pwd = [pwd md5String];
    
    /**
     HMAC:加密方案
     使用一个密钥加密，并且做了两次散列
     密钥来自于服务器 saldf;
     */
   
    pwd = [pwd hmacMD5StringWithKey:@"saldf;"];
    
    NSLog(@"%@",pwd);
}


@end
