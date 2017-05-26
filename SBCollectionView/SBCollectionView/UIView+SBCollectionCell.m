//
//  UIView+SBCollectionCell.m
//  AliPay
//
//  Created by qyb on 2017/5/24.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "UIView+SBCollectionCell.h"
#import <objc/runtime.h>
@implementation UIView (SBCollectionCell)

- (BOOL)effective{
    if ([NSStringFromClass(self.class) isEqualToString:@"SBCollectionView"]) {
        return NO;
    };
    return YES;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setClickItem:(void (^)(NSIndexPath *))clickItem{
    if (!self.clickItem && clickItem) {
        objc_setAssociatedObject(self, @selector(clickItem), clickItem, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}
- (void)setHighLightLayer:(CALayer *)highLightLayer{
    objc_setAssociatedObject(self, @selector(highLightLayer), highLightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CALayer *)highLightLayer{
    CALayer *layer = objc_getAssociatedObject(self, _cmd);
    if (!layer) {
        layer = [[CALayer alloc] init];
        layer.frame = self.bounds;
        layer.backgroundColor = [UIColor colorWithRed:100.f/255.f green:100.f/255.f blue:100.f/255.f alpha:0.5].CGColor;
        self.highLightLayer = layer;
    }
    return layer;
}
- (void (^)(NSIndexPath *))clickItem{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAllowClick:(BOOL (^)())allowClick{
    objc_setAssociatedObject(self, @selector(allowClick), allowClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL(^)())allowClick{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHighLight:(BOOL (^)())highLight{
    objc_setAssociatedObject(self, @selector(highLight), highLight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL (^)())highLight{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if (!self.effective) {
        return;
    }
    if (self.highLight) {
        if (self.highLight()) {
            [self addHighLight];
        }
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.effective) {
        return;
    }
    if (!self.allowClick) {
        return;
    }
    if (self.clickItem) {
        self.clickItem(self.indexPath);
    }
    if (self.highLight) {
        if (self.highLight()) {
             [self removeHighLight];
        }
    }
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if (!self.effective) {
        return;
    }
    if (!self.allowClick) {
        return;
    }
    if (self.highLight) {
        if (self.highLight()) {
            [self removeHighLight];
        }
    }
}

- (void)addHighLight{
    [self.layer addSublayer:self.highLightLayer];
}
- (void)removeHighLight{
    if (self.highLightLayer) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.highLightLayer removeFromSuperlayer];
        });
        
    }
}
@end
