//
//  SEEDPasswordInputView.m
//  XSGeneration
//
//  Created by 李兵 on 2017/12/13.
//  Copyright © 2017年 李兵. All rights reserved.
//

#import "SEEDPasswordInputView.h"

typedef NS_ENUM(NSInteger,renderNOItemSpaceType) {
    renderNOItemSpaceTypeLeft = 0,   //!> item之间没有间隙的左边
    renderNOItemSpaceTypeRight       //!> item之间没有间隙的右边
};


@interface SEEDPasswordInputViewRender : NSObject

+ (UIImage *)p_GridImageViewWithPasswordLength:(NSUInteger)passwordLength borderColor:(UIColor *)color gridWidth:(CGFloat)gridWith gridHeight:(CGFloat)gridHeight lineWidth:(CGFloat)lineWidth currentIndex:(NSInteger)currentIdx curentColor:(UIColor *)currentColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)p_gridImageWithCornerRadius:(CGFloat)cornerRadius borderCorlor:(UIColor *)borderColor lineWidth:(CGFloat)lineWidth gridWidth:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight gridCount:(NSInteger)gridCount itemSpace:(CGFloat)itemSpace currentIndex:(NSInteger)currentIndex currentBorderColor:(UIColor *)currentColor;

+ (CGMutablePathRef)p_createElementWithCornerRadius:(CGFloat)cornerRadius width:(CGFloat)elementWidth height:(CGFloat)elementHeith baseX:(CGFloat)baseX;

+ (UIImage *)p_cirleImageWithColor:(UIColor *)contentColor size:(CGSize)size;

@end


@implementation SEEDPasswordInputViewRender


static NSMutableArray *_pathArr;

/** 不带间距 */
+ (UIImage *)p_GridImageViewWithPasswordLength:(NSUInteger)passwordLength borderColor:(UIColor *)color gridWidth:(CGFloat)gridWith gridHeight:(CGFloat)gridHeight lineWidth:(CGFloat)lineWidth currentIndex:(NSInteger)currentIdx curentColor:(UIColor *)currentColor cornerRadius:(CGFloat)cornerRadius {
    CGSize size = CGSizeMake(gridWith * passwordLength, gridWith);
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //2.获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[self pathArr] removeAllObjects];
    for (int i = 0; i < passwordLength; ++i) {
        CGMutablePathRef path;
        if (i == 0) {
            path = [self p_drawElementWithGridWidth:gridWith gridHeight:gridHeight baseX:i * gridWith CornerRadius:cornerRadius position:renderNOItemSpaceTypeLeft];
        }else if (i == passwordLength -1 ) {
            path = [self p_drawElementWithGridWidth:gridWith gridHeight:gridHeight baseX:i * gridWith CornerRadius:cornerRadius position:renderNOItemSpaceTypeLeft];
        } else {
            path = [self p_drawElementWithGridWidth:gridWith gridHeight:gridHeight baseX:i * gridWith];
        }
//        if (i != currentIdx) {
            [[self pathArr] addObject:(__bridge id _Nonnull)(path)];
//        }
    }
    
    for (id obj in [self pathArr]) {
        CGMutablePathRef path = (__bridge CGMutablePathRef)(obj);
        CGContextAddPath(context, path);
    }
    
    //画线条颜色，设置填充颜色
    [color setStroke];
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(context, lineWidth);
    // 画
    CGContextDrawPath(context,kCGPathFillStroke);
    
    //画当前的框
    
    
    //4.裁剪
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5. 关闭上下文
    UIGraphicsEndImageContext();
    
    for (id obj in [self pathArr]) {
        CGMutablePathRef path = (__bridge CGMutablePathRef)(obj);
        CFRelease(path);
    }
    return image;
}

/** 正常的 */
+ (CGMutablePathRef)p_drawElementWithGridWidth:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight baseX:(CGFloat)baseX {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, baseX, 0);
    CGPathAddLineToPoint(path, nil, baseX + gridWidth, 0);
    CGPathAddLineToPoint(path, nil, baseX + gridWidth, gridHeight);
    CGPathAddLineToPoint(path, nil, baseX, gridHeight);
    return path;
}

+ (CGMutablePathRef)p_drawElementWithGridWidth:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight baseX:(CGFloat)baseX CornerRadius:(CGFloat)cornerRadius position:(renderNOItemSpaceType)type {
    CGMutablePathRef path;
    if (type == renderNOItemSpaceTypeLeft) {
        path = [self p_drawElementWithGridWidthLeft:gridWidth gridHeight:gridHeight baseX:baseX CornerRadius:cornerRadius];
    } else {
        path = [self p_drawElementWithGridWidthRight:gridWidth gridHeight:gridHeight baseX:baseX CornerRadius:cornerRadius];
    }
    return path;
}

+ (CGMutablePathRef)p_drawElementWithGridWidthLeft:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight baseX:(CGFloat)baseX CornerRadius:(CGFloat)cornerRadius {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint topLeft       = CGPointMake(2 * cornerRadius, 2 * cornerRadius);
    CGPoint topRight      = CGPointMake(gridWidth, 0);
    CGPoint bottomLeft    = CGPointMake(2 * cornerRadius, gridHeight - 2 * cornerRadius);
    CGPoint bottomRight   = CGPointMake(gridWidth, gridHeight);
    
    CGPathAddArc(path, nil, topLeft.x, topLeft.y, cornerRadius, 1.5 * M_PI,  M_PI, YES);
    CGPathAddArc(path, nil, bottomLeft.x, bottomLeft.y, cornerRadius, M_PI, 0.5 *  M_PI, YES);
    CGPathAddLineToPoint(path, nil, bottomRight.x, bottomRight.y);
    CGPathAddLineToPoint(path, nil, topRight.x, topRight.y);
    CGPathAddLineToPoint(path, nil, topLeft.x, 0);
    return path;
}

+ (CGMutablePathRef)p_drawElementWithGridWidthRight:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight baseX:(CGFloat)baseX CornerRadius:(CGFloat)cornerRadius {
    CGMutablePathRef path =  CGPathCreateMutable();
    
    CGPoint topLeft = CGPointMake(baseX, 0);
    CGPoint topRight = CGPointMake(baseX + gridWidth - 2 * cornerRadius, 2 * cornerRadius);
    CGPoint bottomLeft = CGPointMake(topLeft.x, gridHeight);
    CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y - 2 * cornerRadius);
    
    CGPathMoveToPoint(path, nil, topLeft.x, topLeft.y);
    CGPathAddLineToPoint(path, nil, topRight.x, 0);
    CGPathAddArc(path, nil, topRight.x, topRight.y, cornerRadius, 1.5 * M_PI, 2 * M_PI, NO);
    CGPathAddArc(path, nil, bottomRight.x, bottomRight.y, cornerRadius, 0, 0.5 * M_PI, NO);
    CGPathAddLineToPoint(path, nil, bottomLeft.x, bottomLeft.y);
    return path;
}

+ (UIImage *)p_gridImageWithCornerRadius:(CGFloat)cornerRadius borderCorlor:(UIColor *)borderColor lineWidth:(CGFloat)lineWidth gridWidth:(CGFloat)gridWidth gridHeight:(CGFloat)gridHeight gridCount:(NSInteger)gridCount itemSpace:(CGFloat)itemSpace currentIndex:(NSInteger)currentIndex currentBorderColor:(UIColor *)currentColor {
    
    [[self pathArr] removeAllObjects];
    
    for (int i = 0; i < gridCount; ++i) {
        if (i == currentIndex) {
            continue;
        }
        CGMutablePathRef path = [self p_createElementWithCornerRadius:cornerRadius width:gridWidth height:gridHeight baseX:(gridWidth + itemSpace) * i];
        [[self pathArr] addObject:(__bridge id _Nonnull)(path)];
    }
    
    CGSize contentSize = CGSizeMake(((gridWidth + itemSpace) * gridCount - itemSpace), gridHeight);
    
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (id obj in [self pathArr]) {
        CGMutablePathRef path = (__bridge CGMutablePathRef)(obj);
        CGContextAddPath(context, path);
    }
    
    //画线条颜色，设置填充颜色
    [borderColor setStroke];
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(context, lineWidth);
    // 画
    CGContextDrawPath(context,kCGPathFillStroke);
    
    CGMutablePathRef path;
    if (currentColor && currentIndex < gridCount) {
         path = [self p_renderCurrentElementColor:currentIndex itemSpace:itemSpace gridWidth:gridWidth cornerRadius:cornerRadius gridHeight:gridHeight context:context borderColor:currentColor lineWidth:lineWidth];
    }
   
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //release
    for (id obj in [self pathArr]) {
        CGMutablePathRef path = (__bridge CGMutablePathRef)(obj);
        CFRelease(path);
    }
    
    if (currentColor && currentIndex < gridCount) {
        CFRelease(path);
    }

    return image;
}

+ (CGMutablePathRef)p_renderCurrentElementColor:(NSInteger)idx itemSpace:(CGFloat)itemSpace gridWidth:(CGFloat)gridWidth cornerRadius:(CGFloat)cornerRadius gridHeight:(CGFloat)gridHeight context:(CGContextRef)context borderColor:(UIColor *)borderColor lineWidth:(CGFloat)lineWidth{
    CGMutablePathRef path = [self p_createElementWithCornerRadius:cornerRadius width:gridWidth height:gridHeight baseX:(gridWidth + itemSpace) * idx];
    
    
    CGContextAddPath(context, path);
    
    //画线条颜色，设置填充颜色
    [borderColor setStroke];
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(context, lineWidth);
    // 画
    CGContextDrawPath(context,kCGPathFillStroke);

    return path;
}

+ (CGMutablePathRef)p_createElementWithCornerRadius:(CGFloat)cornerRadius width:(CGFloat)elementWidth height:(CGFloat)elementHeith baseX:(CGFloat)baseX {
    CGMutablePathRef elementPath = CGPathCreateMutable();
    
    CGPoint topLeftPoint     = CGPointMake(baseX + cornerRadius * 2, cornerRadius * 2);
    CGPoint topRithtPoint    = CGPointMake(baseX + elementWidth - 2 * cornerRadius, 2 * cornerRadius);
    CGPoint bottomLeftPoint  = CGPointMake(baseX + 2 * cornerRadius, elementHeith - 2 * cornerRadius);
    CGPoint bottomRithtPoint = CGPointMake(baseX + elementWidth - 2 * cornerRadius, elementHeith - 2 * cornerRadius);
    
    //弧线
    CGPathAddArc(elementPath, nil, topLeftPoint.x, topLeftPoint.y, cornerRadius, M_PI,  1.5 * M_PI, NO);
    //弧线
    CGPathAddArc(elementPath, nil, topRithtPoint.x, topRithtPoint.y, cornerRadius, 1.5 * M_PI,  2 * M_PI, NO);
    //弧线
    CGPathAddArc(elementPath, nil, bottomRithtPoint.x, bottomRithtPoint.y, cornerRadius, 0,  0.5 * M_PI, NO);
    //弧线
    CGPathAddArc(elementPath, nil, bottomLeftPoint.x, bottomLeftPoint.y, cornerRadius, 0.5 * M_PI,  M_PI, NO);
    
    CGPathAddArc(elementPath, nil, topLeftPoint.x, topLeftPoint.y, cornerRadius, M_PI,  1.5 * M_PI, NO);
  
    
    return elementPath;
}

+ (UIImage *)p_cirleImageWithColor:(UIColor *)contentColor size:(CGSize)size {
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //2.获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //3.画图
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColorWithColor(context, contentColor.CGColor);
    CGContextClip(context);
    //画
    CGContextFillRect(context, rect);
    //4.裁剪
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (NSMutableArray *)pathArr {
    if (!_pathArr) {
        _pathArr = [NSMutableArray array];
    }
    return _pathArr;
}


@end

#pragma mark -

@interface SEEDPasswordInputView ()

@property (assign, nonatomic, readwrite) NSUInteger passWordLength;

@property (weak, nonatomic, readwrite) UIImageView *backgroundImageView;

@property (weak, nonatomic, readwrite) UITextField *pasWordTextField;

/** 是密文的时候的原点ImageView集合 */
@property (strong, nonatomic, readwrite) NSArray<UIImageView *> *dotsArray;

/** 不是密文的时候，显示文字的label集合 */
@property (strong, nonatomic, readwrite) NSArray <UILabel *> *labelsArray;


/** 原点图片的宽度 */
@property (assign, nonatomic, readwrite) CGFloat dotWidth;

/** 输入了多少个字符 */
@property (assign, nonatomic, readwrite) NSInteger inputCount;

/** 密码 */
@property (copy, nonatomic, readwrite) NSString *password;

@end



@implementation SEEDPasswordInputView

static NSString *const LBTextFieldObserverKey = @"UIControlEventEditingChanged";


#pragma mark life cycle
+ (instancetype)viewWithPassworldLength:(NSUInteger)length {
    SEEDPasswordInputView *passWorldView = [[SEEDPasswordInputView alloc] init];
    passWorldView.passWordLength = length;
    return passWorldView;
}

/** 初始化,只在xib创建的时候调用 */
- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepare];
}

/** 初始化, 只在代码创建的时候调用 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview: newSuperview];
    [self removeObservers];
    if (newSuperview) {
        [self addObservers];
    }
}

- (void)dealloc {
    [self removeObservers];
}

/** 需要的对应的数据 和 必不可少的UI */
- (void)prepare {
    //初始化数据
    _dotWidth = 10;
    _defaultBorderColor = [UIColor darkGrayColor];
    _gridLineWidth = 2.0;
    _secureTextEntry = YES;
    _inputCount = 0;
    _passWordLength = 6;
    //初始化UI
    UITextField *passWordTextField = [[UITextField alloc] init];
    passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    passWordTextField.tintColor = [UIColor clearColor];
    passWordTextField.textColor = [UIColor clearColor];
    [self addSubview:passWordTextField];
    passWordTextField.secureTextEntry = YES;
    self.pasWordTextField = passWordTextField;
    
    //TextField 的背景 图片
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
}

#pragma mark Action
- (void)refreshUIWithPassWord:(NSString *)password{
    //设置隐藏与否
    self.inputCount = password.length;
    // 如果是文字则需要给赋值
    if (self.isSecureTextEntry == NO) {
        for (int i = 0; i < password.length; i ++) {
            UILabel *obj = [self.labelsArray objectAtIndex:i];
            obj.text = [NSString stringWithFormat:@"%c",[password characterAtIndex:i]];
        }
    }
    
    if (self.itemSpace > 0) {
        self.backgroundImageView.image = [SEEDPasswordInputViewRender p_gridImageWithCornerRadius:self.itemCornerRadius borderCorlor:self.defaultBorderColor lineWidth:self.gridLineWidth gridWidth:(CGRectGetWidth(self.frame) + self.itemSpace)/self.passWordLength - self.itemSpace gridHeight:CGRectGetHeight(self.frame) gridCount:self.passWordLength itemSpace:self.itemSpace currentIndex:password.length?:0 currentBorderColor:self.selectedBorderColor?:self.defaultBorderColor];
    } else {
        self.backgroundImageView.image = [SEEDPasswordInputViewRender p_GridImageViewWithPasswordLength:self.passWordLength borderColor:self.defaultBorderColor gridWidth:CGRectGetWidth(self.frame)/self.passWordLength gridHeight:CGRectGetHeight(self.frame) lineWidth:self.gridLineWidth currentIndex:password.length?:0 curentColor:self.selectedBorderColor?:self.defaultBorderColor cornerRadius:self.itemCornerRadius];
        
    }
    
}

- (void)seedBecomeFirstResponder {
    [self.pasWordTextField becomeFirstResponder];
}

#pragma mark observers
- (void)removeObservers{
    [self.pasWordTextField removeTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)addObservers{
    [self.pasWordTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark private



#pragma mark delegate
- (void)textChanged:(UITextField *)sender{
    NSString *passWord = sender.text;
    if (passWord.length > self.passWordLength) {
        passWord = [passWord substringToIndex:self.passWordLength];
        sender.text = passWord;
    }
    
    self.password = passWord;
    NSLog(@"文本是：%@",passWord);
    [self refreshUIWithPassWord:passWord];
    if ([self.delegate respondsToSelector:@selector(SEEDPassWordInputView:text:complete:)]) {
        BOOL flag = NO;
        if (passWord.length == self.passWordLength) {
            flag = YES;
        }
        [self.delegate SEEDPassWordInputView:self text:passWord complete:flag];
    }
    
}

#pragma mark layouts
/** 布局 */
- (void)layoutSubviews {
    [self placeSubViews];
    [super layoutSubviews];
}

- (void)placeSubViews {
    //textField Frame
    
    CGRect passwordFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.pasWordTextField.frame = passwordFrame;
    //背景 imageView frame
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    //需要依赖frame 只能放在这里
    CGFloat gridWidth;
    if (self.itemSpace > 0) {
        self.backgroundImageView.image = [SEEDPasswordInputViewRender p_gridImageWithCornerRadius:self.itemCornerRadius borderCorlor:self.defaultBorderColor lineWidth:self.gridLineWidth gridWidth:(CGRectGetWidth(self.frame) + self.itemSpace)/self.passWordLength - self.itemSpace gridHeight:CGRectGetHeight(self.frame) gridCount:self.passWordLength itemSpace:self.itemSpace currentIndex:self.pasWordTextField.text.length?self.pasWordTextField.text.length:0 currentBorderColor:self.selectedBorderColor?:self.defaultBorderColor];
        gridWidth = (CGRectGetWidth(self.frame) + self.itemSpace)/self.passWordLength - self.itemSpace;
    } else {
         self.backgroundImageView.image = [SEEDPasswordInputViewRender p_GridImageViewWithPasswordLength:self.passWordLength borderColor:self.defaultBorderColor gridWidth:CGRectGetWidth(self.frame)/self.passWordLength gridHeight:CGRectGetHeight(self.frame) lineWidth:self.gridLineWidth currentIndex: self.pasWordTextField.text.length?:0 curentColor:self.selectedBorderColor?:self.defaultBorderColor cornerRadius:self.itemCornerRadius];
        gridWidth = CGRectGetWidth(self.frame)/self.passWordLength;
    }
   
    [self placeDotViews:gridWidth];
    
    [self placeLables:gridWidth];
   
    
}

- (void)placeDotViews:(CGFloat)gridWidth {
    
    if (self.itemSpace > 0) {
        // 小圆点的摆放位置
        for (int i = 0; i < self.dotsArray.count; i++) {
            UIImageView * obj = [self.dotsArray objectAtIndex:i];
            CGFloat w = self.dotWidth;
            CGFloat h = w;
            CGFloat x = gridWidth / 2 + (gridWidth + self.itemSpace) * i - self.dotWidth / 2 ;
            CGFloat y = CGRectGetHeight(self.frame) / 2.0 - h/2.0;
            CGRect frame = CGRectMake(x, y, w,h );
            obj.frame = frame;
        }
    } else {
        // 小圆点的摆放位置
        for (int i = 0; i < self.dotsArray.count; i++) {
            UIImageView * obj = [self.dotsArray objectAtIndex:i];
            CGFloat w = self.dotWidth;
            CGFloat h = w;
            CGFloat x = gridWidth/2.0 - w/2.0 + gridWidth * i;
            CGFloat y = CGRectGetHeight(self.frame) / 2.0 - h/2.0;
            CGRect frame = CGRectMake(x, y, w,h );
            obj.frame = frame;
        }
    }
    
}


- (void)placeLables:(CGFloat)gridWidth {
    // 不是密文的Labels  frame
    
    if (self.itemSpace > 0) {
        for (int i = 0; i < self.labelsArray.count; i ++) {
            
            UILabel *label = [self.labelsArray objectAtIndex:i];
            
            CGFloat labX = (gridWidth + self.itemSpace) * i;
            CGFloat labY = 0;
            CGFloat labW = gridWidth;
            CGFloat labH = CGRectGetHeight(self.frame);
            CGRect labFrame = CGRectMake(labX, labY, labW, labH);
            
            label.frame = labFrame;
        }
        
    } else {
        for (int i = 0; i < self.labelsArray.count; i ++) {
            
            UILabel *label = [self.labelsArray objectAtIndex:i];
            
            CGFloat labX = i * gridWidth;
            CGFloat labY = 0;
            CGFloat labW = gridWidth;
            CGFloat labH = CGRectGetHeight(self.frame);
            CGRect labFrame = CGRectMake(labX, labY, labW, labH);
            
            label.frame = labFrame;
        }
    }
    
}

#pragma mark getter && setter
/** 懒加载密文情况下的UIImageVie Array */
- (NSArray<UIImageView *> *)dotsArray{
    if (_dotsArray == nil) {
        NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:self.passWordLength];
        for (int i = 0; i<self.passWordLength; i++) {
            UIImage *dotImage = [SEEDPasswordInputViewRender p_cirleImageWithColor:self.dotColor size:CGSizeMake(self.dotWidth, self.dotWidth)];
            UIImageView *dotImageView = [[UIImageView alloc] initWithImage:dotImage];
            [dataSource addObject:dotImageView];
            [self addSubview:dotImageView];
        }
        _dotsArray = dataSource.copy;
    }
    return _dotsArray;
}


- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor {
    if (_selectedBorderColor == selectedBorderColor) {
        return;
    }
    _selectedBorderColor = selectedBorderColor;
    
    if (self.itemSpace > 0) {
        self.backgroundImageView.image = [SEEDPasswordInputViewRender p_gridImageWithCornerRadius:self.itemCornerRadius borderCorlor:self.defaultBorderColor lineWidth:self.gridLineWidth gridWidth:(CGRectGetWidth(self.frame) + self.itemSpace)/self.passWordLength - self.itemSpace gridHeight:CGRectGetHeight(self.frame) gridCount:self.passWordLength itemSpace:self.itemSpace currentIndex:self.pasWordTextField.text.length?self.pasWordTextField.text.length:0 currentBorderColor:self.selectedBorderColor?:self.defaultBorderColor];
    } else {
        self.backgroundImageView.image = [SEEDPasswordInputViewRender p_GridImageViewWithPasswordLength:self.passWordLength borderColor:self.defaultBorderColor gridWidth:CGRectGetWidth(self.frame)/self.passWordLength gridHeight:CGRectGetHeight(self.frame) lineWidth:self.gridLineWidth currentIndex: self.pasWordTextField.text.length?:0 curentColor:self.selectedBorderColor?:self.defaultBorderColor cornerRadius:self.itemCornerRadius];
    }
}


/** 懒加载不是密文的Label Array */
- (NSArray<UILabel *> *)labelsArray{
    if (_labelsArray == nil) {
        NSMutableArray *dataSource  = [NSMutableArray arrayWithCapacity:self.passWordLength];
        for (int i = 0; i < self.passWordLength; i++) {
            UILabel *lab = [[UILabel alloc] init];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = self.textColor?:self.dotColor;
            lab.font = [UIFont systemFontOfSize:14];
            [self addSubview:lab];
            [dataSource addObject:lab];
        }
        _labelsArray = dataSource.copy;
    }
    return _labelsArray;
}

- (void)setPassWordLength:(NSUInteger)passWordLength{
    
    _passWordLength = passWordLength;
    self.inputCount = self.pasWordTextField.text.length;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    if (secureTextEntry == _secureTextEntry) {
        return;
    }
    _secureTextEntry = secureTextEntry;
    self.pasWordTextField.secureTextEntry = secureTextEntry;
    self.inputCount = self.pasWordTextField.text.length;
}

- (void)setInputCount:(NSInteger)inputCount{
    if (inputCount == _inputCount) {
        if (inputCount != 0) {
            return;
        }
        
    }
    _inputCount = inputCount;
    if (self.isSecureTextEntry == true) {
        //是密文 隐藏所有labels ， 显示输入的个数的原点，剩下的隐藏
        [self.labelsArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        for (int i = 0; i < inputCount; i ++) {
            UIImageView *obj = [self.dotsArray objectAtIndex:i];
            obj.hidden = NO;
        }
        for (NSInteger i = inputCount; i < self.dotsArray.count; i++) {
            UIImageView *obj = [self.dotsArray objectAtIndex:i];
            obj.hidden = YES;
        }
    }else{
        //是明文 隐藏所有iamgeView 圆点，显示输入个数的Label，剩下的全隐藏
        [self.dotsArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        for (NSInteger i = 0; i < inputCount; i++) {
            UILabel *obj = [self.labelsArray objectAtIndex:i];
            obj.hidden = NO;
        }
        
        for (NSInteger i = inputCount; i < self.labelsArray.count; i ++) {
            UILabel *obj = [self.labelsArray objectAtIndex:i];
            obj.hidden = YES;
        }
    }
}



@end



