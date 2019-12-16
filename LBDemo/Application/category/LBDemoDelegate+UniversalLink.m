//
//  LBDemoDelegate+UniversalLink.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/16.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBDemoDelegate+UniversalLink.h"


@implementation LBDemoDelegate (UniversalLink)


#pragma mark Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *url = userActivity.webpageURL;
        NSLog(@"sdf");
       // TODO 根据需求进行处理
    }
      // TODO 根据需求进行处理
    return YES;
}


@end
