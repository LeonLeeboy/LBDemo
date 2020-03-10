//
//  EHICalendarFlowLayout.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarFlowLayout.h"

const CGFloat EHICalendarFlowLayoutMinInterItemSpacing = 0.0f;
const CGFloat EHICalendarFlowLayoutMinLineSpacing = 0.0f;
const CGFloat EHICalendarFlowLayoutInsetTop = 5.0f;
const CGFloat EHICalendarFlowLayoutInsetLeft = 0.0f;
const CGFloat EHICalendarFlowLayoutInsetBottom = 5.0f;
const CGFloat EHICalendarFlowLayoutInsetRight = 0.0f;
const CGFloat EHICalendarFlowLayoutHeaderHeight = 30.0f;

@implementation EHICalendarFlowLayout

-(id)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = EHICalendarFlowLayoutMinInterItemSpacing;
        self.minimumLineSpacing = EHICalendarFlowLayoutMinLineSpacing;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(EHICalendarFlowLayoutInsetTop,
                                             EHICalendarFlowLayoutInsetLeft,
                                             EHICalendarFlowLayoutInsetBottom,
                                             EHICalendarFlowLayoutInsetRight);
        self.headerReferenceSize = CGSizeMake(0, EHICalendarFlowLayoutHeaderHeight);
        
        //Note: Item Size is defined using the delegate to take into account the width of the view and calculate size dynamically
    }
    return self;
}


@end
