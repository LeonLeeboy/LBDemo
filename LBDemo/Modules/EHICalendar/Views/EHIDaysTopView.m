//
//  EHIDaysTopView.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/12.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHIDaysTopView.h"

@interface EHIDaysTopView ()

@property (nonatomic, strong) NSArray *WeaksArrM;

@end

@implementation EHIDaysTopView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    CGFloat W = (DeviceSize.width - 28.0) / self.WeaksArrM.count;
     for (NSUInteger i = 0; i < self.WeaksArrM.count; i++) {
         UILabel *WeakLbl = [[UILabel alloc] initWithFrame:CGRectMake(14 + W * i, 0, W, 42)];
         WeakLbl.textColor = kEHIHexColor(0x999999);
         WeakLbl.font = autoFONT(12);
         WeakLbl.textAlignment = NSTextAlignmentCenter;
         WeakLbl.text = [self.WeaksArrM objectAtIndex:i];
         [self addSubview:WeakLbl];
     }
    
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"calendar_top_weeks"].CGImage);
}


#pragma mark - Getter && Setter
- (NSArray *)WeaksArrM {
    if (!_WeaksArrM) {
        _WeaksArrM = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    }
    return _WeaksArrM;
}

@end
