//
//  SBCollectionView.h
//  AliPay
//
//  Created by qyb on 2017/5/12.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCollectionProtocol.h"

typedef UIView * (^ItemBlock)(SBCollectionView *cv,NSIndexPath *indexPath);

typedef UIView * (^ReloadBlock)(SBCollectionView *cv,UIView *item,NSIndexPath *indexPath);
typedef void (^DidSelectBlock)(SBCollectionView *cv,NSIndexPath *indexPath);

typedef NSInteger (^CountBlock)(SBCollectionView *cv);

@interface SBCollectionView : UIView
//
//最小水平距离 defaults 0
@property (assign,nonatomic) CGFloat minHorizontalSpace;
//垂直距离 defaults 0
@property (assign,nonatomic) CGFloat verticalSpace;
//允许缓存 defaults YES
@property (assign,nonatomic) BOOL allowCache;
//允许点击
@property (assign,nonatomic) BOOL allowClick;
//点高亮
@property (assign,nonatomic) BOOL selectHighLight;
//内容 的 contentInset 参考scrollview
@property (assign,nonatomic) UIEdgeInsets contentInset;
//设置itemSize的大小 在实现了 layoutsForCollectionView:indexPath: 代理后此itemSize将不会使用
@property (assign,nonatomic) CGSize itemSize;

/**
 通过block控制的实例化

 @param frame sbcollectionview.frame
 @param itemCount itemCount
 @param itemSize item 的大小 size
 @param item 通过item获取一个item
 @param reloadItem 刷新item
 @param didSelectItem 选择item的回调
 @return sbcollectionview
 */
- (instancetype)initWithFrame:(CGRect)frame itemCount:(CountBlock)itemCount itemSize:(CGSize) itemSize item:(ItemBlock)item reloadItem:(ReloadBlock)reloadItem didSelectItem:(DidSelectBlock)didSelectItem;


/**
 通过代理方式实例化

 @param frame frame
 @param itemSize item的大小
 @param delegate 代理
 @return sbcollectionview
 */
- (instancetype)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize delegate:(id <SBCollectionProtocol>)delegate;


//代理的优先级将会高于block

/**
  通过block 告知一个初始化的item
 */
@property (copy,nonatomic) ItemBlock item;

/**
 通过block 刷新item的内容
 */
@property (copy,nonatomic) ReloadBlock reloadItem;

/**
 选中item的block回调
 */
@property (copy,nonatomic) DidSelectBlock didSelectItem;

@property (copy,nonatomic) CountBlock countItem;

/**
  告知item的个数   用block方式必须实现的
 */
//@property (copy,nonatomic) NSInteger (^itemsCount)(SBCollectionView *cv);



/**
 代理
 */
@property (weak,nonatomic) id <SBCollectionProtocol> delegate;

/**
 根据传入参数刷新所有 item
 */
- (void)reloadData;

/**
 刷新单个item

 @param indexPath indexpath
 */
- (void)reloadItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 刷新一组items

 @param indexPaths indexPaths
 */
- (void)reloadItemsAtIndexPaths:(NSArray <NSIndexPath*>*)indexPaths;

/**
 删除item

 @param indexPath indexPath
 @param animated 动画
 @param completion 结束block count剩余的item个数
 */
- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL) animated completion:(void(^)(NSInteger count))completion;

/**
 删除一组items

 @param indexPaths indexPaths
 @param animated 动画
 @param completion 结束block count剩余的item个数
 */
- (void)deleteItemsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths animated:(BOOL) animated completion:(void(^)(NSInteger count))completion;

/**
 添加一个或多个item

 @param count item个数
 @param indexPath 添加的位置
 @param animated 动画
 @param completion 结束后返回的block可以在这里对新添加的item进行渲染 插入后的item数量
 */
- (void)insertItemsOfCount:(NSInteger)count AtIndexPath:(NSIndexPath *)indexPath animated:(BOOL) animated completion:(void(^)(UIView *item,NSInteger count))completion;
@end
