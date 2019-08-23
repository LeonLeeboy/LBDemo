//
//  EHIDetecctionItemView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIDetecctionItemView.h"
#define kEHIHexColor_53DCCE kEHIHexColor(0x53DCCE) //对的
#define kEHIHexColor_FF5C5C kEHIHexColor(0xFF5C5C)//错误的

static CGFloat kDefaultCycleAnimationDuration = 2.0f;
@interface EHIDetecctionItemView ()

/** 渲染model */
@property (nonatomic, strong, readwrite) EHIDetecctionItemModel *renderModel;

/** 结果动画视图 */
@property (nonatomic, strong) CALayer *resultLayer;

@property (nonatomic, strong) CAShapeLayer *circleShapeLayer;

@property (nonatomic, strong) NSMutableArray *layers;

@property (nonatomic, strong) UILabel *textLab;

@end

@implementation EHIDetecctionItemView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectZero]) {
        
        [self prepareData];
        
        [self setupSubViews];
        
        [self renderViewWithModel:self.renderModel];
    }
    return self;
}

- (void)prepareData {
    
}

- (void)setupSubViews {
    [self addSubview:self.textLab];
    
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.equalTo(self.textLab.superview);
    }];
}


#pragma mark public
- (void)renderViewWithModel:(EHIDetecctionItemModel *)model {
    
    self.renderModel = model;
    
    self.textLab.text = model.itemName?:@"检查";
    
    [self startAnimation];
}

- (void)startAnimation {
    
    [self.resultLayer removeAllSublayers];

    self.resultLayer = nil;
    
    
    EHiWeakSelf(self)
    [self p_startCycleAnimationWithStrokeColor:kEHIHexColor_53DCCE duration:self.renderModel.animationDuration?:kDefaultCycleAnimationDuration Complementation:^(BOOL finished) {
        EHiStrongSelf(self)
        if (finished) {
            [self p_setInnerAnimationAndCyleBackGround];
        }
    }];
}
#pragma mark  private
- (CGMutablePathRef)createCircleCGPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat centerX = self.width / 2.0;
    CGFloat centerY = self.width / 2.0;
    CGFloat cornerRadius = self.width / 2.0;
    CGPathAddArc(path, nil, centerX, centerY,cornerRadius,-0.5 * M_PI , 1.5 * M_PI, NO);
    return path;
}

//- (void)p_removeSubLayer:(CALayer *)layer {
//    if (layer.sublayers.count == 0) {
//        [layer pop_removeAllAnimations];
//        return;
//    }
//    NSArray<CALayer *> *subLayers = layer.sublayers;
//    for (CALayer *obj in subLayers) {
//        [self p_removeSubLayer:obj];
//        [obj removeFromSuperlayer];
//        [obj pop_removeAllAnimations];
//    }
//}

- (void)p_setInnerAnimationAndCyleBackGround {
    
    if (self.renderModel.isSuccess) {
        [self startCheckMarkAnimation];
    } else {
        [self startCrossAnimation];
    }
    
    if (self.renderModel.success) {
        return;
    }
    
    [self.circleShapeLayer removeFromSuperlayer];
    [self p_startCycleAnimationWithStrokeColor:kEHIHexColor_FF5C5C duration:0 Complementation:nil];
}

- (void)p_startCycleAnimationWithStrokeColor:(UIColor *)strokeColor duration:(CGFloat)duration Complementation:(void(^)(BOOL finished))completion {
    
    if (self.circleShapeLayer) {
        [self.circleShapeLayer removeFromSuperlayer];
    }
    
    CGMutablePathRef path = [self createCircleCGPath];
    
    CAShapeLayer *circleShapeLayer = [[CAShapeLayer alloc] init];
    
    circleShapeLayer.path = path;
    circleShapeLayer.fillColor = [UIColor clearColor].CGColor;

    circleShapeLayer.strokeColor = strokeColor.CGColor;
    self.circleShapeLayer = circleShapeLayer;
    [self.resultLayer addSublayer:circleShapeLayer];
    
    POPBasicAnimation *circleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    circleAnimation.duration = duration;

    
    circleAnimation.fromValue = @(0);
    circleAnimation.toValue = @(1);
    circleAnimation.beginTime = CACurrentMediaTime();
    circleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (!finished) {
            return;
        }
        if (completion) {
            completion(YES);
        }
    };
    
    [circleShapeLayer pop_addAnimation:circleAnimation forKey:@"circleAnimation"];
    free(path);
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

/** 每一个边的动画 */
- (void)lineAnimationWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint isLast:(BOOL)isLast {
    // 添加路径和layer
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
//    #FF5C5C
    layer.strokeColor = self.renderModel.isSuccess?kEHIHexColor_53DCCE.CGColor:kEHIHexColor_FF5C5C.CGColor;
    layer.lineWidth = 1.2;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [self.resultLayer addSublayer:layer];
    
    // 添加动画
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animation.duration = 0.4;
    animation.fromValue = @0.f;
    animation.toValue = @1.0f;
    animation.beginTime = CACurrentMediaTime();
    if (isLast) {
        EHiWeakSelf(self)
        animation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            if (finished) {
                EHiStrongSelf(self)
                if (self.didFinishedAnimationBlcok) {
                    self.didFinishedAnimationBlcok(self.renderModel.success);
                }
            }
        };
    }
    [layer pop_addAnimation:animation forKey:@"line"];
}

#pragma mark getter
- (CALayer *)resultLayer {
    if (!_resultLayer) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, 0, self.width, self.width);
        layer.cornerRadius = layer.width / 2.0;
        layer.masksToBounds = YES;
        
        [self.layer addSublayer:layer];
        _resultLayer = layer;
    }
    return _resultLayer;
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab  = [[UILabel alloc] init];
        _textLab.numberOfLines = 0;
        _textLab.textColor = kEHIHexColor_7B7B7B;
        _textLab.font = autoFONT(12);
        _textLab.textAlignment = NSTextAlignmentRight;
        _textLab.text = @" ";
    }
    return _textLab;
}

@end
