//
//  EHICarLicensePlateTextField.m
//  LBDemo
//
//  Created by Bean lee on 2019/8/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHICarLicensePlateTextField.h"

#pragma mark -
#pragma mark -  渲染item模型

@interface EHICarLicensePlateTextFieldItemModel : NSObject

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *normalBorderColor;

@property (nonatomic, strong) UIColor *selectedBorderColor;

@property (nonatomic, strong) UIColor *normalBackGroundColor;

@property (nonatomic, strong) UIColor *selectedBackGroundColor;

@property (nonatomic, strong) UIColor *normalTextColor;

@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, assign) CGSize itemSize;

@end

@implementation EHICarLicensePlateTextFieldItemModel

@end
#pragma mark -
#pragma mark -  每个item的View

@interface EHICarLicensePlateTextFieldItem : UIButton

@property (nonatomic, strong) EHICarLicensePlateTextFieldItemModel *itemModel;

- (void)renderViewWithModel:(EHICarLicensePlateTextFieldItemModel *)model;

@end

@implementation EHICarLicensePlateTextFieldItem

- (void)renderViewWithModel:(EHICarLicensePlateTextFieldItemModel *)model {
    self.itemModel = model;
    [self setTitle:model.text forState:UIControlStateNormal];
    [self setTitle:model.text forState:UIControlStateSelected];
    
    [self setBackgroundImage:[UIImage imageWithColor:model.normalBackGroundColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:model.selectedBackGroundColor] forState:UIControlStateSelected];
    
    [self setTitleColor:model.selectedTextColor forState:UIControlStateSelected];
    [self setTitleColor:model.normalBackGroundColor forState:UIControlStateNormal];
    
    self.selected = model.isSelected;
}

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

static NSInteger textFieldNumbers = 9;

@interface EHICarLicensePlateTextField ()

@property (nonatomic, strong, readwrite) NSArray<EHICarLicensePlateTextFieldItem *> *buttonArray;

@property (nonatomic, strong, readwrite) UITextField *textField;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray<EHICarLicensePlateTextFieldItemModel *> *itemModels;

@end

@implementation EHICarLicensePlateTextField

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {

    [self addSubview:self.textField];
    
    EHiWeakSelf(self)
    [self.buttonArray enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EHiStrongSelf(self)
        [self addSubview:obj];
    }];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark Action
- (void)didClickItemView:(EHICarLicensePlateTextFieldItem *)sender {

    [self.textField becomeFirstResponder];
    
    NSInteger index = sender.tag;
    
    EHICarLicensePlateTextFieldItemModel *model;
    if (self.itemModels.count > index) {
        model = self.itemModels[index];
    }
    
    model.selected = YES;
    
    self.currentIndex = index;
}


#pragma mark getter
- (NSArray<EHICarLicensePlateTextFieldItem *> *)buttonArray {
    if (!_buttonArray) {
        NSMutableArray *contentArr = [NSMutableArray arrayWithCapacity:textFieldNumbers];
        for (int i = 0; i < textFieldNumbers; ++i) {
            EHICarLicensePlateTextFieldItem *itemView = [[EHICarLicensePlateTextFieldItem alloc] init];
            [itemView addTarget:self action:@selector(didClickItemView:) forControlEvents:UIControlEventTouchUpInside];
            itemView.tag = i;
            [contentArr addObject:itemView];
        }
        _buttonArray = contentArr.copy;
    }
    return _buttonArray;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

@end
