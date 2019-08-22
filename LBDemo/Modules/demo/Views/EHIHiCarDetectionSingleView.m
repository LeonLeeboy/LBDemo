//
//  EHIHiCarDetectionSingleView.m
//  1haiiPhone
//
//  Created by LuckyCat on 2018/12/13.
//  Copyright © 2018年 EHi. All rights reserved.
//

#import "EHIHiCarDetectionSingleView.h"
#import "POP.h"

@interface EHIHiCarDetectionSingleView ()

/** 序号 */
@property (nonatomic, strong) UILabel *numLabel;

/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;

/** 结果动画视图 */
@property (nonatomic, strong) CALayer *resultLayer;

@end

@implementation EHIHiCarDetectionSingleView

#pragma mark - Setter

- (void)setDetailModel:(EHIHiCarDetectionDetailModel *)detailModel {
    _detailModel = detailModel;

    self.numLabel.text = [NSString stringWithFormat:@"%@", @(detailModel.Id)];
    self.contentLabel.text = detailModel.Title;
}

#pragma mark - 动画

/** 开始动画 */
- (void)startAnimation {
    [self performSelector:@selector(startCircleAnimation) withObject:nil afterDelay:0.15];
}

/** 开始圆圈动画 */
- (void)startCircleAnimation {
    BOOL isSuccess = self.detailModel.Result;
    self.resultLayer.backgroundColor = isSuccess ? kEHIHexColor_29B7B7.CGColor : kEHIHexColor_FF7E00.CGColor;
    
    // layer里面加一个白色的圆
    CALayer *circleLayer = [[CALayer alloc] init];
    circleLayer.frame = self.resultLayer.bounds;
    circleLayer.backgroundColor = [UIColor whiteColor].CGColor;
    circleLayer.cornerRadius = circleLayer.width / 2.0;
    circleLayer.masksToBounds = YES;
    [self.resultLayer addSublayer:circleLayer];

    // 白色的圆进行缩小动画
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.3;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
    animation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        if (finished) {
            // 结束以后,进行对号动画/错误动画
            if (isSuccess) {
                [self startCheckMarkAnimation];
            } else {
                [self startCrossAnimation];
            }
        }
    };
    [circleLayer pop_addAnimation:animation forKey:@"circle"];
}

/** 对号动画 */
- (void)startCheckMarkAnimation {
    CGFloat a = self.resultLayer.bounds.size.width;
    
    CGPoint centerPoint = CGPointMake(a * 4.5 / 10, a * 7.0 / 10);
    CGPoint leftPoint = CGPointMake(a * 2.7 / 10, a * 5.4 / 10);
    CGPoint rightPoint = CGPointMake(a * 7.8 / 10, a * 3.8 / 10);
    
    // 分别添加左勾、右勾两个边动画
    [self lineAnimationWithStartPoint:centerPoint endPoint:leftPoint isLast:NO];
    [self lineAnimationWithStartPoint:centerPoint endPoint:rightPoint isLast:YES];
}

/** 叉号动画 */
- (void)startCrossAnimation {
    CGFloat a = self.resultLayer.bounds.size.width;
    
    CGFloat min = 3.2, max = 6.8;
    CGPoint centerPoint = CGPointMake(a * 5.0 / 10, a * 5.0 / 10);
    CGPoint leftUpPoint = CGPointMake(a * min / 10, a * min / 10);
    CGPoint leftDownPoint = CGPointMake(a * min / 10, a * max / 10);
    CGPoint rightUpPoint = CGPointMake(a * max / 10, a * min / 10);
    CGPoint rightDownPoint = CGPointMake(a * max / 10, a * max / 10);
    
    // 分别添加左上、左下、右上、右下四个边动画
    [self lineAnimationWithStartPoint:centerPoint endPoint:leftUpPoint isLast:NO];
    [self lineAnimationWithStartPoint:centerPoint endPoint:leftDownPoint isLast:NO];
    [self lineAnimationWithStartPoint:centerPoint endPoint:rightUpPoint isLast:NO];
    [self lineAnimationWithStartPoint:centerPoint endPoint:rightDownPoint isLast:YES];
}

/** 每一个边的动画 */
- (void)lineAnimationWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint isLast:(BOOL)isLast {
    // 添加路径和layer
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = kEHIHexColor_FFFFFF.CGColor;
    layer.lineWidth = 1.2;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [self.resultLayer addSublayer:layer];
    
    // 添加动画
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animation.duration = 0.4;
    animation.fromValue = @0.f;
    animation.toValue = @1.0f;
    if (isLast) {
        animation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            if (finished) {
                if (self.didFinishedAnimationBlcok) {
                    self.didFinishedAnimationBlcok();
                }
            }
        };
    }
    [layer pop_addAnimation:animation forKey:@"line"];
}

#pragma mark - Getter

- (UILabel *)numLabel {
    if (!_numLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, autoWidthOf6(7), self.height)];
        label.font = autoFONT(12);
        label.textColor = kEHIHexColor_CCCCCC;
        label.text = @"--";
        
        [self addSubview:label];
        _numLabel = label;
    }
    return _numLabel;
}

- (CALayer *)resultLayer {
    if (!_resultLayer) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(self.width - self.height, 0, self.height, self.height);
        layer.cornerRadius = layer.width / 2.0;
        layer.masksToBounds = YES;
        
        [self.layer addSublayer:layer];
        _resultLayer = layer;
    }
    return _resultLayer;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.numLabel.right + autoWidthOf6(12), 0, 0, self.height)];
        label.width = self.resultLayer.left - label.left - autoWidthOf6(10);
        label.font = autoFONT(12);
        label.textColor = kEHIHexColor_7B7B7B;
        label.text = @"--";
        
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

@end
