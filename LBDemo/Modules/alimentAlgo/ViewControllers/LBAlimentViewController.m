//
//  LBAlimentViewController.m
//  LBDemo
//
//  Created by 李兵 on 2020/1/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "LBAlimentViewController.h"


@interface LBAlimentViewController ()

@end

@implementation LBAlimentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    int a = [self alimentAlgorithm:23];
//    NSLog(@"%d",a);
    
    BOOL success = [@"true" boolValue];
    NSLog(@"sadf");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     int a = [self alimentAlgorithm:23];
     NSLog(@"%d",a);
}

- (int)alimentAlgorithm:(int)x {
    return (x + 7) &~7;
}

- (BOOL)testTime {
    NSString *sepStr = @":";

       // 分割字符
       NSArray * (^componentsTimeAction)(NSString *timeStr) = ^ NSArray*(NSString *timeStr) {
           return [timeStr componentsSeparatedByString:sepStr];
       };
       
       // 验证是否合格
       BOOL (^verify)(NSString *timeStr) = ^BOOL(NSString *timeStr) {
           if (!timeStr) {
               return false;
           }
           
           if (![timeStr containsString:sepStr]) {
               return false;
           }
           
           if (componentsTimeAction) {
               NSArray *components = componentsTimeAction(timeStr);
               if (components.count < 2) {
                   return false;
               }
           }
           return true;
       };
       
       /** 获得小时，分钟 */
       RACTuple* (^getHourAndMinuteAction)(NSString *timeStr) = ^ RACTuple*(NSString *timeStr) {
           
           NSArray *rst = componentsTimeAction(timeStr);
           
           if (rst.count >= 2) {
               NSInteger Hour = [rst[0] integerValue];
               NSInteger minute = [rst[1] integerValue];
               return [RACTuple tupleWithObjects:@(Hour),@(minute), nil];
           }
           return nil;
       };
       
       /** 时间戳 */
       NSTimeInterval (^getTimeStamp)(NSString *timeStr) = ^NSTimeInterval(NSString *timeStr) {
           if (getHourAndMinuteAction) {
               RACTuple *hourMin = getHourAndMinuteAction(timeStr);
               if (hourMin.count >= 2) {
                   NSInteger Hour = [hourMin.first integerValue];
                   NSInteger Minute = [hourMin.second integerValue];
                   return Hour * 3600 + Minute * 60;
               }
               return 0;
           }
           return 0;
       };
       
    NSString *beginStr = @"8:00";
    NSString *endStr = @"16:";
    // 时间格式定死： 08:00  ， 20:00
    if (verify(beginStr) && verify(endStr)) {
        NSTimeInterval open = getTimeStamp(beginStr);
        NSTimeInterval close = getTimeStamp(endStr);
        NSDate *currentDate = [NSDate date];
        NSString *currentDateStr = [NSString stringWithFormat:@"%ld:%ld",(long)currentDate.hour,(long)currentDate.minute];
        NSTimeInterval current = getTimeStamp(currentDateStr);
        if (current >= open && current <= close) {
            return YES;
        }
        return NO;
    }
    
       return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
