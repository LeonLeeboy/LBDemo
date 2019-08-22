//
//  EHICarLicensePlateTextField.m
//  LBDemo
//
//  Created by Bean lee on 2019/8/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHICarLicensePlateTextField.h"
#import "SEEDLicensePlateView.h"

#pragma mark -
#pragma mark -  渲染item模型

@implementation EHICarLicensePlateTextFieldItemModel

//YYModelSynthCoderAndHash

@end


#pragma mark -
#pragma mark -  每个item的View

static UIColor *defaultNormalBackgroundColor() {
    return kEHIHexColor_F8F8F8;
}

static UIColor *defaultSelectedBackgroundColor() {
    return  kEHIHexColor_FF7E00;
}

static UIColor *defaultSelectedTitleColor() {
    return  kEHIHexColor_333333;
}

static UIColor *defaultNormalTitleColor() {
    return  kEHIHexColor_333333;
}

@interface EHICarLicensePlateTextFieldItem : UIButton

@property (nonatomic, strong) EHICarLicensePlateTextFieldItemModel *itemModel;


- (void)renderViewWithModel:(EHICarLicensePlateTextFieldItemModel *)model;

@end

@implementation EHICarLicensePlateTextFieldItem

#pragma mark public
/** 渲染 */
- (void)renderViewWithModel:(EHICarLicensePlateTextFieldItemModel *)model {
    
    self.itemModel = model;
    
    if (model.text.length > 0) {
        self.titleLabel.backgroundColor = [UIColor clearColor];
    } else {
        self.titleLabel.backgroundColor = [UIColor whiteColor];
    }
    
    [self setTitle:model.text?:@"" forState:UIControlStateNormal];
    [self setTitle:model.text?:@"" forState:UIControlStateSelected];
    
    [self setBackgroundImage:[UIImage imageWithColor:model.normalBackGroundColor?:defaultNormalBackgroundColor()] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:model.selectedBackGroundColor?:defaultSelectedBackgroundColor()] forState:UIControlStateSelected];
    
    [self setTitleColor:model.selectedTextColor?:defaultSelectedTitleColor() forState:UIControlStateSelected];
    [self setTitleColor:model.normalTextColor?:defaultNormalTitleColor() forState:UIControlStateNormal];
    
    if (model.newEnergy) {
        [self setBackgroundImage:[self p_createEnergyBackGroundView].snapshotImage forState:UIControlStateNormal];
        
        self.backgroundColor = [UIColor clearColor];
    } else {
        [self setBackgroundImage:[UIImage imageWithColor:model.normalBackGroundColor?:defaultNormalBackgroundColor()] forState:UIControlStateNormal];
    }
    
    
    
    
    self.selected = model.isSelected;
}

#pragma mark private
- (UIView *)p_createEnergyBackGroundView {
    UIView *energyControl = [[UIView alloc] init];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hicar_leaf"]];
    UILabel *lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = kEHIHexColor_7B7B7B;
    lab.text = @"新能源";
    lab.font = autoFONT(9);
    
    [energyControl addSubview:imgView];
    [energyControl addSubview:lab];
    
    imgView.frame = CGRectMake( (autoWidthOf6(34) - autoWidthOf6(18)) / 2, autoHeightOf6(8), autoWidthOf6(18), autoHeightOf6(13));
    lab.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + autoHeightOf6(2), autoWidthOf6(34),autoHeightOf6(17));
    
    energyControl.backgroundColor = [kEHIHexColor_29B7B7 colorWithAlphaComponent:0.3];
    
    energyControl.frame =CGRectMake(0, 0,  autoWidthOf6(34), CGRectGetMaxY(lab.frame));
    return energyControl;
}

#pragma mark getter && setter
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = self.itemModel.selectedBorderColor.CGColor;
    } else {
        self.layer.borderColor = self.itemModel.normalBorderColor.CGColor;
    }
}

@end


#pragma mark -
#pragma mark 车牌框的View

static NSInteger textFieldNumbers = 7;

@interface EHICarLicensePlateTextField ()<UITextFieldDelegate,SEEDLicensePlateDelegate>

@property (nonatomic, strong, readwrite) NSArray<EHICarLicensePlateTextFieldItem *> *buttonArray;

@property (nonatomic, strong, readwrite) UITextField *textField;

/** 当前index */
@property (nonatomic, assign, readwrite) NSInteger currentIndex;

@property (nonatomic, strong, readwrite) NSArray<EHICarLicensePlateTextFieldItemModel *> *itemModels;


@property (nonatomic, assign, readwrite) NSInteger itemLength;

@property (nonatomic, strong, readwrite) NSString *carInfo;

@property (nonatomic, assign, readwrite) BOOL didClickItem;

@end

@implementation EHICarLicensePlateTextField

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.itemLength = textFieldNumbers;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.textField];
    
    self.textField.delegate = self;
    
    
    EHiWeakSelf(self)
    [self.buttonArray enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EHiStrongSelf(self)
        [self addSubview:obj];
    }];
    
    //布局
    [self layoutViews];
}

- (void)layoutViews {
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //小圆点 之前的两个框
    EHICarLicensePlateTextFieldItem *firstItem = self.buttonArray[0];
    EHICarLicensePlateTextFieldItem *secondItem = self.buttonArray[1];
    [firstItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.height.equalTo(firstItem.superview);
        make.width.mas_equalTo(autoWidthOf6(34));
    }];
    
    [secondItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstItem.mas_right).with.offset(autoWidthOf6(9));
        make.top.bottom.equalTo(firstItem);
        make.width.mas_equalTo(autoWidthOf6(34));
    }];
    
    //小圆点
    UIView *dot = [[UIView alloc] init];
    [self addSubview:dot];
    dot.backgroundColor = kEHIHexColor_CCCCCC;
    dot.layer.cornerRadius = autoWidthOf6(3);
    
    [dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondItem.mas_right).with.offset(autoWidthOf6(5));
        make.width.height.mas_equalTo(autoWidthOf6(6));
        make.centerY.equalTo(dot.superview);
    }];
    
    //原点之后的框
    EHICarLicensePlateTextFieldItem *preObjc;
    for (int i = 2; i < self.buttonArray.count; ++i) {
        if (i >= self.buttonArray.count) {
            break;
        }
        
        EHICarLicensePlateTextFieldItem *obj = self.buttonArray[i];
        if (i == 2) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(dot.mas_right).with.offset(autoWidthOf6(5));
                make.top.bottom.equalTo(obj.superview);
                make.width.mas_equalTo(autoWidthOf6(34));
            }];
            preObjc = obj;
        } else {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preObjc.mas_right).with.offset(autoWidthOf6(9));
                make.top.bottom.equalTo(preObjc);
                make.width.equalTo(preObjc);
            }];
            preObjc = obj;
        }
        
        //最后一个
        if (i == self.buttonArray.count - 1) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
            }];
        }
    }
}


#pragma mark Public
- (void)licensePlateBecomeFirstResponder {
    [self.textField becomeFirstResponder];
}

- (void)licensePlateResignFirstResponder {
    [self.textField resignFirstResponder];
}


- (void)renderViewWithItemModels:(NSArray<EHICarLicensePlateTextFieldItemModel *> *)items {
    
    [self p_emptyData];
    [self p_emptySubViews];
    
    __block NSInteger index;
    [items enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            index = idx;
        }
    }];
    
    self.currentIndex = index;
    self.didClickItem = YES;
    
    self.itemLength = items.count;
    self.itemModels = [items copy];
    
    [self setupSubViews];
    
    //渲染
    [self p_renderItemsView];
    
    
}

#pragma mark private
/** 渲染每一个Item */
- (void)p_renderItemsView {
    for (int i = 0; i < self.buttonArray.count; ++i) {
        EHICarLicensePlateTextFieldItem *obj = self.buttonArray[i];
        if (i >= self.itemModels.count) {
            return;
        }
        [obj renderViewWithModel:self.itemModels[i]];
    }
}

/** 取消所有的选择 */
- (void)p_cancelAllItemsSelected {
    [self.itemModels enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
}

/** 是否是删除 */
- (BOOL)p_isDeleteWithStr:(NSString *)text {
    BOOL rst = NO;
    if ([text isEqualToString:@""]) {
        rst = YES;
    }
    return rst;
}

/** 清空数据 */
- (void)p_emptyData {
    self.buttonArray = nil;
    self.itemModels = nil;
}

/** 清空子view */
- (void)p_emptySubViews {
    [self removeAllSubviews];
}

/** 获得车牌号 */
- (NSString *)p_getCarInfo {
    __block NSString *rst = @"";
    [self.itemModels enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        rst = [NSString stringWithFormat:@"%@%@",rst,obj.text?:@""];
    }];
    
    return rst;
}

#pragma mark Action
/** 点击item事件 */
- (void)didClickItemView:(EHICarLicensePlateTextFieldItem *)sender {
    self.didClickItem = YES;
    
    [self.textField becomeFirstResponder];
    
    NSInteger index = sender.tag;
    //暂存选中的index
    self.currentIndex = index;
    
    if (sender.selected) {
        return;
    }
    
    //取消掉所有的选中状态
    [self p_cancelAllItemsSelected];
    
    //设置选中状态
    EHICarLicensePlateTextFieldItemModel *model;
    if (self.itemModels.count > index) {
        model = self.itemModels[index];
    }
    model.selected = YES;
    
    //点击了 就隐藏响应图片
    if (index == self.itemLength - 1) {
        self.itemModels.lastObject.newEnergy = NO;
    }
    
    //重新渲染
    [self p_renderItemsView];
    
    if (self.currentIndex == 0) {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleProvince) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleProvince];
        }
    } else {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleABC) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleABC];
        }
    }
}

/** 输入事件 */
- (void)doInputActionWithText:(NSString *)text {
    
    if (self.currentIndex >= self.itemModels.count) {
        self.currentIndex -= 1;
        return;
    }
    
    [self p_cancelAllItemsSelected];
    
    if (self.didClickItem) {
        self.itemModels[self.currentIndex].text = text;
        if (self.currentIndex != self.itemLength - 1) {
            self.currentIndex += 1;
        }
        self.itemModels[self.currentIndex].selected = YES;
    } else {
        if (self.currentIndex == 0) {
            self.itemModels[self.currentIndex + 1].selected = YES;
            self.itemModels[self.currentIndex].text = text;
            self.currentIndex = self.currentIndex + 1;
            
        } else if (self.currentIndex == self.itemLength - 1) {
            self.itemModels[self.currentIndex].text = text;
            self.itemModels[self.currentIndex].selected = YES;
            self.itemModels.lastObject.newEnergy = NO;
            self.currentIndex = self.itemLength - 1;
        } else {
            self.itemModels[self.currentIndex].text = text;
            self.currentIndex = self.currentIndex + 1;
            self.itemModels[self.currentIndex].selected = YES;
        }
    }
    self.didClickItem = NO;
    self.textField.text = @"123456";
    
    self.carInfo = [self p_getCarInfo];
    NSLog(@"----carinfo ---- %@", self.carInfo);
    
    [self p_renderItemsView];
    
    if (self.currentIndex == 0) {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleProvince) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleProvince];
        }
    } else {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleABC) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleABC];
        }
    }
    
}

/** 删除事件 */
- (void)doDeleteActionWithText:(NSString *)text {
    if (self.currentIndex >= self.itemModels.count) {
        self.currentIndex = self.itemModels.count - 1;
        return;
    }
    
    [self p_cancelAllItemsSelected];
    
    if (self.didClickItem) {
        self.itemModels[self.currentIndex].text = text;
        self.itemModels[self.currentIndex].selected = YES;
    } else {
        if (self.currentIndex == 0) {
            self.itemModels[self.currentIndex].text = text;
            self.itemModels[self.currentIndex].selected = YES;
        }else if (self.currentIndex == self.itemLength - 1) {
            if ([self.itemModels[self.currentIndex].text isEqualToString:@""]) {
                self.currentIndex = self.currentIndex - 1;
                self.itemModels[self.currentIndex].selected = YES;
                self.itemModels[self.currentIndex].text = text;
            } else {
                self.itemModels[self.currentIndex].text = text;
                self.itemModels[self.currentIndex].selected = YES;
            }
            
        } else {
            self.currentIndex -= 1;
            self.itemModels[self.currentIndex].text = text;
            self.itemModels[self.currentIndex].selected = YES;
        }
    }
    self.didClickItem = NO;
    
    self.textField.text = @"123456";
    self.carInfo = [self p_getCarInfo];
    NSLog(@"----carinfo ---- %@", self.carInfo);
    //更新UI
    [self p_renderItemsView];
    
    if (self.currentIndex == 0) {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleProvince) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleProvince];
        }
    } else {
        SEEDLicensePlateView *licensePlate = (SEEDLicensePlateView *)self.textField.inputView;
        if (licensePlate.renderModel.style != SEDDLicensePlateStyleABC) {
            [licensePlate renderViewWithWithStyle:SEDDLicensePlateStyleABC];
        }
    }
}

#pragma mark delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"----shouldChangeCharactersInRange----%@",textField.text);
    NSLog(@"----shouldChangeCharactersInRange----%@",string);
    if ([self p_isDeleteWithStr:string]) {
        // 删除事件
        [self doDeleteActionWithText:string];
    } else {
        //输入事件
        [self doInputActionWithText:string];
    }
    if (range.location + string.length <= self.itemLength) {
        return YES;
    } else {
        return NO;
    }
}

- (void)licensePlateView:(SEEDLicensePlateView *)licensePlateView didClickText:(NSString *)text clickEvent:(SEDDLicesePlateViewEvent)clickEvent {
    
    switch (clickEvent) {
        case SEDDLicesePlateViewEventClickItem: { // 普通按钮
            [self doInputActionWithText:text];
        }
            break;
        case SEDDLicesePlateViewEventClickABC: { // 点击ABC
            [licensePlateView renderViewWithWithStyle:SEDDLicensePlateStyleABC];
        }
            break;
        case SEDDLicesePlateViewEventClickDel: { //点击删除
            // 删除事件
            [self doDeleteActionWithText:text];
        }
            break;
        case SEDDLicesePlateViewEventClickLicensePlate: { //点击省份
            [licensePlateView renderViewWithWithStyle:SEDDLicensePlateStyleProvince];
        }
            break;
        case SEDDLicesePlateViewEventClickDone: { //完成事件
            
        }
            break;
    }
    
}

#pragma mark getter
- (NSArray<EHICarLicensePlateTextFieldItem *> *)buttonArray {
    if (!_buttonArray) {
        
        NSMutableArray *contentArr = [NSMutableArray arrayWithCapacity:self.itemLength];
        
        for (int i = 0; i < self.itemLength; ++i) {
            
            EHICarLicensePlateTextFieldItem *itemView = [[EHICarLicensePlateTextFieldItem alloc] init];
            
            [itemView addTarget:self action:@selector(didClickItemView:) forControlEvents:UIControlEventTouchUpInside];
            
            itemView.tag = i;
            //初始化渲染模型
            EHICarLicensePlateTextFieldItemModel *model = self.itemModels[i];
            [itemView renderViewWithModel:model];
            
            [contentArr addObject:itemView];
        }
        
        _buttonArray = contentArr.copy;
    }
    return _buttonArray;
}

- (NSArray<EHICarLicensePlateTextFieldItemModel *> *)itemModels {
    if (!_itemModels) {
        NSMutableArray *contentArr = [NSMutableArray arrayWithCapacity:self.itemLength];
        for (int i = 0; i < self.itemLength; ++i) {
            EHICarLicensePlateTextFieldItemModel *model = [[EHICarLicensePlateTextFieldItemModel alloc] init];
            if (i == 0) {
                model.selected = YES;
            }
            [contentArr addObject:model];
        }
        _itemModels = contentArr.copy;
    }
    return _itemModels;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.tintColor = [UIColor clearColor];
        _textField.textColor = [UIColor clearColor];
        SEEDLicensePlateView *inputView = [[SEEDLicensePlateView alloc] initWithStyle:SEDDLicensePlateStyleProvince];
        inputView.delegate = self;
        inputView.frame = CGRectMake(0, 0, Main_Screen_Width, autoHeightOf6(231));
        _textField.inputView = inputView;
    }
    return _textField;
}

/** 设置自定义键盘 */
- (void)setInputView:(UIView *)inputView {
    self.textField.inputView = inputView;
}



@end
