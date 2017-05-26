//
//  UIView+SBCollectionCell.h
//  AliPay
//
//  Created by qyb on 2017/5/24.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SBCollectionCell)
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (copy,nonatomic) void (^clickItem)(NSIndexPath *indexPath);
@property (strong,nonatomic) CALayer *highLightLayer;
@property (copy,nonatomic) BOOL (^allowClick)();
@property (copy,nonatomic) BOOL (^highLight)();
@property (assign,nonatomic) BOOL effective;
@end
