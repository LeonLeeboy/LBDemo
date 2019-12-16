//
//  Task.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/6.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "Task.h"

@interface Task ()

@property (nonatomic, strong, readwrite) NSString *ID;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL sel;

@property (nonatomic, strong) NSArray *arguments;

@end

@implementation Task

- (instancetype)initWithTarget:(id)target methond:(SEL)sel arguments:(NSArray *)arguments {
    if (self = [super init]) {
        self.ID = [Utils getRandomUUid];
        
        self.target = target;
        self.sel = sel;
        self.arguments = arguments;
    }
    return self;
}


- (NSString *)getUUID {
    return self.ID;
}


@end
