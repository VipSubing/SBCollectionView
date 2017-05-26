//
//  SBColletionLayout.h
//  AliPay
//
//  Created by qyb on 2017/5/23.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SBColletionLayout : NSObject
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (assign,nonatomic) CGRect frame;
@property (assign,nonatomic) CGRect bounds;
@property (assign,nonatomic) CGPoint center;
@property (assign,nonatomic) CGSize size;
@property (assign,nonatomic) float alpha;
@property (assign,nonatomic) BOOL hidden;
@property (assign,nonatomic) BOOL opaque;

- (instancetype)clear;

@end
