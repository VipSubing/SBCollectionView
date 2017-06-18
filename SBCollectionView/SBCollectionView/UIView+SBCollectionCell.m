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

- (BOOL)sb_effective{
    if ([NSStringFromClass(self.class) isEqualToString:@"SBCollectionView"]) {
        return NO;
    };
    return YES;
}
- (void)setSb_indexPath:(NSIndexPath *)indexPath{
    
    objc_setAssociatedObject(self, @selector(sb_indexPath), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)sb_indexPath{
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setSb_clickItem:(void (^)(NSIndexPath *))clickItem{
    
    if (!self.sb_clickItem && clickItem) {
        objc_setAssociatedObject(self, @selector(sb_clickItem), clickItem, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}
- (void)setSb_highLightLayer:(CALayer *)highLightLayer{
    
    objc_setAssociatedObject(self, @selector(sb_highLightLayer), highLightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CALayer *)sb_highLightLayer{
    CALayer *layer = objc_getAssociatedObject(self, _cmd);
    if (!layer) {
        layer = [[CALayer alloc] init];
        layer.frame = self.bounds;
        layer.backgroundColor = [UIColor colorWithRed:100.f/255.f green:100.f/255.f blue:100.f/255.f alpha:0.5].CGColor;
        self.sb_highLightLayer = layer;
    }
    return layer;
}
- (void (^)(NSIndexPath *))sb_clickItem{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSb_allowClick:(BOOL (^)())allowClick{
    
    objc_setAssociatedObject(self, @selector(sb_allowClick), allowClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL(^)())sb_allowClick{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSb_highLight:(BOOL (^)())highLight{
    
    objc_setAssociatedObject(self, @selector(sb_highLight), highLight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL (^)())sb_highLight{
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)sb_addHighLight{
    [self.layer addSublayer:self.sb_highLightLayer];
}
- (void)sb_removeHighLight{
    if (self.sb_highLightLayer) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.sb_highLightLayer removeFromSuperlayer];
        });
        
    }
}

@end
