//
//  LBFIFOCache.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBFIFOCache.h"
#import "DoubleLinkedList.h"

@interface LBFIFOCache ()

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) NSMutableDictionary *map;

@property (nonatomic, strong) DoubleLinkedList *list;

@end


@implementation LBFIFOCache

- (instancetype)initWithCapcity:(NSInteger)capacity {
    if (self = [super init]) {
        self.capacity = capacity;
        self.size = 0;
        self.map = @{}.mutableCopy;
    }
    return self;
}

#pragma mark - public
- (id)getValue:(NSString *)key {
    if (![self.map containsObjectForKey:key]) {
        return nil;
    } else {
        ListNode *node = self.map[key];
        return node.value;
    }
}

- (void)putValue:(id)value key:(id)key {
    if (!self.capacity) {
        return;
    }
    
    if ([self.map containsObjectForKey:key]) {
        ListNode *node = self.map[key];
        [self.list remove:node];
        node.value = value;
        [self.list append:node];
    } else {
        if (self.size == self.capacity) {
            ListNode *node = [self.list pop];
            if ([self.map containsObjectForKey:node.key]) {
                [self.map removeObjectForKey:node.key];
                self.size -= 1;
            }
            
            node = [[ListNode alloc ] initWithValue:value key:key];
            [self.list append:node];
            self.map[key] = value;
            self.size += 1;
        }
    }
}

- (void)print {
    [self.list print];
}

#pragma mark - private
- (DoubleLinkedList *)list {
    if (!_list) {
        _list = [[DoubleLinkedList alloc] initWithCapcity:self.capacity];
    }
    return _list;
}


@end
