//
//  EHIWaterFlowCollectionViewLayout.h
//  LBCollectionViewLayout
//
//  Created by ivan on 2018/1/23.
//

#import <UIKit/UIKit.h>


@protocol EHIWaterFlowCollectionViewLayouDelegate <NSObject>

@optional
- (CGFloat)itemHeightAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface EHIWaterFlowCollectionViewLayout : UICollectionViewLayout

@property (weak , nonatomic) id <EHIWaterFlowCollectionViewLayouDelegate>delegate;

+ (instancetype)layoutWithColumnsNumbers:(NSUInteger)numbers lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace;

- (void)setLineSpace:(CGFloat)lineSpace;

- (void)setItemSpace:(CGFloat)itemSpace;

@end
