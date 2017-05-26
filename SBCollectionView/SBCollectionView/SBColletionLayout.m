//
//  SBColletionLayout.m
//  AliPay
//
//  Created by qyb on 2017/5/23.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBColletionLayout.h"

@implementation SBColletionLayout

- (instancetype)init{
    if (self = [super init]) {
        
        _opaque = YES;
        _alpha = 1.0f;
    }
    return self;
}

- (instancetype)clear{
    self.indexPath = nil;
    self.frame = CGRectZero;
    self.bounds = CGRectZero;
    self.size = CGSizeZero;
    self.center = CGPointZero;
    self.alpha = 1.f;
    self.hidden = NO;
    self.opaque = YES;
    return self;
}
- (void)setFrame:(CGRect)frame{
    _frame = frame;
    _bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
}
@end
