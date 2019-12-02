//
//  BinarySearchTree.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "BinarySearchTree.h"

@interface BinarySearchTree ()

@property (nonatomic, strong) Node *tree;

@end

@implementation BinarySearchTree

/** 查找 */
- (Node *)find:(id)value {
    Node *node = self.tree;
    while (!node) {
        if (node.value > value) {
            node = node.left;
        } else if (node.value < value) {
            node = node.right;
        } else {
            return node;
        }
    }
    return nil;
}

/** 插入 */
- (void)insert:(id)value {
    if (!_tree) {
        self.tree = [[Node alloc] initWithValue:value];
        return;
    }
    Node *p = self.tree;
    while (p != nil) {
        if (value > p.value) {
            if (p.right == nil) {
                p.right = [[Node alloc] initWithValue:value];
                return;
            }
            p = p.right;
        } else {
            if (p.left == nil) {
                p.left = [[Node alloc] initWithValue:value];
                return;
            } else {
                p = p.left;
            }
        }
    }
}

- (void)del:(id)value {
    Node *p = self.tree;
    Node *pp = nil;
    // 查找node 和 父node
    while (p != nil && p.value != value) {
        pp = p;
        if (value < p.value) {
            p = p.left;
        } else {
            p = p.right;
        }
    }
    
    // 要删除的节点有两个孩子
    /**
        1. 查找右子树最小的节点，将最小的节点的父节点的子节点置为nil
     */
    if (p.left != nil && p.right != nil) {
        Node *minP = p.right;
        Node *minPP = p;
        while (minP.left != nil) {
            minPP = minP;
            minP = minP.left;
        }
        p.value = minP.value;
        
        p = minP;
        pp = minP.left;
    }
    
    // 要删除的节点是叶子节点 或者仅有一个节点
    Node *child;
    if (p.left != nil) child = p.left;
    else if (p.right != nil) child = p.right;
    else child = nil;
    
    if (pp == nil) self.tree = child;// 删除的是根节点
    else if (pp.left == p) pp.left = child;
    else pp.right = child;
    
}

- (Node *)getMax {
    Node *p = self.tree;
    if (p == nil) {
        return nil;
    }
    

    while (p.right != nil) {
        p = p.right;
    }
    
    return p;
}

- (Node *)getMin {
    Node *p = self.tree;
    if (p == nil) {
        return nil;
    }
    
    while (p.left != nil) {
        p = p.left;
    }
    return p;
}

@end
