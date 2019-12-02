//
//  Node.h
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject

@property (nonatomic, strong) id value;

@property (nonatomic, strong) Node *left;

@property (nonatomic, strong) Node *right;

- (instancetype)initWithValue:(id)value;

@end
