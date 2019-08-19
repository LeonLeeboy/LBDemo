//
//  EHIGetAndChangeCarInputView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/14.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIGetAndChangeCarInputView.h"
#import "SEEDPasswordInputView.h"

static NSInteger frontItemCount = 2;
static NSInteger behindNormalItemCount = 6;
static NSInteger behindNewEnergyItemCount = 7;

static NSInteger frontViewTag = 456;
static NSInteger behindNormalViewTag = 457;
static CGFloat cellItemWidth () {
    return autoWidthOf6(39);
}

static CGFloat cellItemSpace () {
    return autoWidthOf6(5);
}
static CGFloat cellCornerRadius () {
    return autoWidthOf6(5);
}

@interface EHIGetAndChangeCarInputView ()<SEEDPassWorldDelegate>

@property (nonatomic, strong) SEEDPasswordInputView *frontInput;

@property (nonatomic, strong) SEEDPasswordInputView *behindInput;

@end

@implementation EHIGetAndChangeCarInputView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.frontInput];
    [self addSubview:self.behindInput];
    
    [_frontInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(0);
        make.height.mas_equalTo(autoWidthOf6(39));
        make.width.mas_greaterThanOrEqualTo(cellItemWidth() * self.frontInput.passWordLength);
    }];
    [_behindInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.frontInput.mas_right).with.offset(autoWidthOf6(19));
        make.top.bottom.equalTo(self.frontInput);
        make.height.mas_equalTo(cellItemWidth());
        make.width.mas_greaterThanOrEqualTo((cellItemWidth() + cellItemSpace()) * self.behindInput.passWordLength - cellItemSpace());
        make.right.mas_equalTo(0);
    }];
    
}

#pragma mark delegate
- (void)SEEDPassWordInputView:(SEEDPasswordInputView *)inputView text:(NSString *)text complete:(BOOL)complete {
    if (inputView.tag == frontViewTag) {
        if (complete) {
            self.behindInput.selectedBorderColor = kEHIHexColor_FF7E00;
            [self.behindInput seedBecomeFirstResponder];
        } else {
             self.behindInput.selectedBorderColor = kEHIHexColor_CCCCCC;
        }
    } else if( inputView.tag == behindNormalViewTag) {
        if (text.length > 0) {
            self.behindInput.selectedBorderColor = kEHIHexColor_FF7E00;
        } else {
           
            if ([self.frontInput.delegate respondsToSelector:@selector(SEEDPassWordInputView:text:complete:)]) {
                if (self.frontInput.password.length == frontItemCount) {
                    [self.frontInput.delegate SEEDPassWordInputView:self.frontInput text:self.frontInput.password complete:YES];
                }
            }
            [self.frontInput seedBecomeFirstResponder];
        }
    }
}

#pragma mark getter && setter

- (SEEDPasswordInputView *)frontInput {
    if (!_frontInput) {
        _frontInput = [SEEDPasswordInputView viewWithPassworldLength:frontItemCount];
        _frontInput.delegate = self;
        _frontInput.tag = frontViewTag;
        _frontInput.backgroundColor = [UIColor clearColor];
        _frontInput.defaultBorderColor = [UIColor redColor];
        _frontInput.selectedBorderColor = kEHIHexColor_CCCCCC;
        _frontInput.itemCornerRadius = cellCornerRadius();
        _frontInput.secureTextEntry = NO;
    }
    return _frontInput;
}

- (SEEDPasswordInputView *)behindInput {
    if (!_behindInput) {
        _behindInput = [SEEDPasswordInputView viewWithPassworldLength:behindNormalItemCount];
        _behindInput.delegate = self;
        _behindInput.tag = behindNormalViewTag;
        _behindInput.defaultBorderColor = kEHIHexColor_CCCCCC;
        _behindInput.backgroundColor = [UIColor clearColor];
        _behindInput.itemSpace = cellItemSpace();
        _behindInput.itemCornerRadius = cellCornerRadius();
        _behindInput.secureTextEntry = NO;
    }
    return _behindInput;
}

-(void)dealloc {
    NSLog(@"dealloc");
}

@end
