//
//  SBCollectionProtocol.h
//  AliPay
//
//  Created by qyb on 2017/5/12.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SBCollectionView;
@class SBColletionLayout;
@protocol SBCollectionProtocol <NSObject>
@required

/**
 通过这个方法告诉cv item的个数

 @param cv SBCollectionView
 @return count
 */
- (NSInteger)itemsCountForCollectionView:(SBCollectionView *)cv;

/**
 创建item

 @param cv SBCollectionView
 @param indexPath indexPath
 @return item
 */
- (UIView *)collectionView:(SBCollectionView *)cv itemInitAtIndexPath:(NSIndexPath *)indexPath;

/**
 渲染item
 @param cv SBCollectionView
 @param object item
 @param indexPath index
 @return item
 */
- (UIView *)collectionView:(SBCollectionView *)cv drawedObject:(UIView *)object indexPath:(NSIndexPath *)indexPath;

@optional

/**
 点击事件

 @param cv SBCollectionView
 @param indexPath indexPath
 */
- (void)collectionView:(SBCollectionView *)cv didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 自定义item的layout 布局

 @param cv SBCollectionView
 @param layout 需要自定义的layout
 @param indexPath indexPath
 @return 自定义完成的layout
 */
- (SBColletionLayout *)layoutsForCollectionView:(SBCollectionView *)cv layout:(SBColletionLayout *)layout indexPath:(NSIndexPath *)indexPath;
@end
