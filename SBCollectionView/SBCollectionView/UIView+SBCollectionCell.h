//
//  UIView+SBCollectionCell.h
//  AliPay
//
//  Created by qyb on 2017/5/24.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SBCollectionCell)
@property (strong,nonatomic) NSIndexPath *sb_indexPath;
@property (copy,nonatomic) void (^sb_clickItem)(NSIndexPath *indexPath);
@property (strong,nonatomic) CALayer *sb_highLightLayer;
@property (copy,nonatomic) BOOL (^sb_allowClick)();
@property (copy,nonatomic) BOOL (^sb_highLight)();
@property (assign,nonatomic) BOOL sb_effective;

- (void)sb_addHighLight;
- (void)sb_removeHighLight;
@end
