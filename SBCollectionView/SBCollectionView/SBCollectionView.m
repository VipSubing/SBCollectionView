//
//  SBCollectionView.m
//  AliPay
//
//  Created by qyb on 2017/5/12.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBCollectionView.h"
#import "SBColletionLayout.h"
#import "StaticCacheManager.h"
#import "UIView+SBCollectionCell.h"

static NSInteger const __tagbase = 1000;
static NSString *const __cachekey = @"__sb_collection_cache_key";
@interface SBCollectionView()
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (assign,nonatomic) NSInteger itemCount;
@end
@implementation SBCollectionView
{
    StaticCacheManager *_cacheManager;
    
    SBColletionLayout *_privateLayout;
    NSInteger _rowCount;
    CGFloat _privateHorizontalSpace;
    NSInteger _beforeCount;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static float screen_width(){
    return screen_width_ratio(1.0f);
}
static float screen_width_ratio(float ratio){
    float screenwidth = [UIScreen mainScreen].bounds.size.width;
    return screenwidth*ratio;
}

- (instancetype)initWithFrame:(CGRect)frame itemCount:(CountBlock)itemCount itemSize:(CGSize)itemSize item:(ItemBlock)item reloadItem:(ReloadBlock)reloadItem didSelectItem:(DidSelectBlock)didSelectItem{
    if (self = [self init]) {
        self.frame = frame;
        _itemSize = itemSize;
        _countItem = itemCount;
        _item = item;
        _reloadItem = reloadItem;
        _didSelectItem = didSelectItem;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize delegate:(id <SBCollectionProtocol>)delegate{
    if (self = [self init]) {
        self.frame = frame;
        _itemSize = itemSize;
        _delegate = delegate;
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        _allowCache = YES;
        _verticalSpace = 0;
        _minHorizontalSpace = 0;
        _cacheManager = [StaticCacheManager shareManager];
        [_cacheManager createItemForKey:__cachekey];
        _dataSource = [NSMutableArray new];
        _itemCount = 0;
        _beforeCount = 0;
        _allowClick = YES;
        _selectHighLight = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)reloadData{
    _rowCount = [self countOfRow];
    [self sb_reloadForCycleWithFrom:0 to:self.itemCount];
}
- (void)sb_reloadForCycleWithFrom:(NSInteger)fromIndex to:(NSInteger)toIndex{
    while (fromIndex < toIndex) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromIndex inSection:0];
        [self reloadItem:[self itemWithIndexPath:indexPath] atIndexPath:indexPath];
        fromIndex ++;
    }
    while (fromIndex<_beforeCount) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromIndex inSection:0];
        UIView *item = [self itemWithIndexPath:indexPath];
        [item removeFromSuperview];
        fromIndex ++;
    }
    _beforeCount = toIndex;
}
- (void)sb_reloadContentForCycleWithFrom:(NSInteger)fromIndex to:(NSInteger)toIndex{
    while (fromIndex < toIndex) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromIndex inSection:0];
        [self reloadContentWithItem:[self itemWithIndexPath:indexPath] atIndexPath:indexPath];
        fromIndex ++;
    }
}
- (void)sb_reloadLayoutForCycleWithFrom:(NSInteger)fromIndex to:(NSInteger)toIndex{
    while (fromIndex < toIndex) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromIndex inSection:0];
        [self reloadLayoutWithItem:[self itemWithIndexPath:indexPath] atIndexPath:indexPath];
        toIndex ++;
    }
    while (fromIndex<_beforeCount) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fromIndex inSection:0];
        UIView *item = [self itemWithIndexPath:indexPath];
        [item removeFromSuperview];
        fromIndex ++;
    }
    _beforeCount = toIndex;
}
- (void)reloadItemAtIndexPath:(NSIndexPath *)indexPath{
    UIView *item = [self viewWithTag:[self tagWithIndexPath:indexPath]];
    NSAssert(item,@"item of indexpath not exist");
    [self reloadItem:item atIndexPath:indexPath];
}

- (void)reloadItemsAtIndexPaths:(NSArray <NSIndexPath*>*)indexPaths{
    for (NSIndexPath *indexPath in indexPaths) {
        [self reloadItemAtIndexPath:indexPath];
    }
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath{
    [self deleteItemsAtIndexPaths:@[indexPath]];
}
- (void)deleteItemsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths{
    NSInteger index = [indexPaths firstObject].row+indexPaths.count;
     NSInteger deleteCount = 0;
    for (NSIndexPath *indexPath in indexPaths) {
        UIView *delItem = [self viewWithTag:[self tagWithIndexPath:indexPath]];
        if (!delItem) {
            break;
        }
        [delItem removeFromSuperview];
        deleteCount ++;
    }
   
    while (index<_beforeCount) {
        UIView *item = [self viewWithTag:[self tagWithIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
        NSAssert(item,@"item of indexpath not exist");
        [self moveItem:item forUnits:-indexPaths.count];
        index++;
        
    }
    _beforeCount = _beforeCount-deleteCount;
}

- (void)deleteItemsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths animated:(BOOL) animated completion:(void(^)(BOOL finished))completion{
    NSTimeInterval duration = 0.0f;
    if (animated) {
        duration = 0.3f;
    }
    [UIView animateWithDuration:duration animations:^{
        [self deleteItemsAtIndexPaths:indexPaths];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}
- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL) animated completion:(void(^)(NSInteger count))completion{
    NSTimeInterval duration = 0.0f;
    if (animated) {
        duration = 0.3f;
    }
    [UIView animateWithDuration:duration animations:^{
        [self deleteItemAtIndexPath:indexPath];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(_beforeCount);
        }
    }];
}
- (void)insertItemsOfCount:(NSInteger)count AtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    while (index<_beforeCount) {
        UIView *item = [self viewWithTag:[self tagWithIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
        NSAssert(item,@"item of indexpath not exist");
        [self moveItem:item forUnits:count];
        index++;
    }
    
    index = indexPath.row;
    while (index < indexPath.row+count) {
        NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self reloadLayoutWithItem:[self newItem:insertIndexPath] atIndexPath:insertIndexPath];
        index++;
    }
    _beforeCount = _beforeCount+count;
}
- (void)insertItemsOfCount:(NSInteger)count AtIndexPath:(NSIndexPath *)indexPath animated:(BOOL) animated completion:(void(^)(UIView *item,NSInteger count))completion{
    NSTimeInterval duration = 0.0f;
    if (animated) {
        duration = 0.3f;
    }
    [UIView animateWithDuration:duration animations:^{
        [self insertItemsOfCount:count AtIndexPath:indexPath];
    } completion:^(BOOL finished) {
        if (completion) {
             completion([self itemWithIndexPath:indexPath],_beforeCount);
        }
    }];
}
- (void)moveItem:(UIView *)item forUnits:(NSInteger)units{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item.indexPath.row+units inSection:0];
    NSLog(@"indexPath.row:  %d",indexPath.row);
    if (indexPath.row<0 || indexPath.row>_beforeCount+units-1) {
        return;
    }
    SBColletionLayout *layout = [self nomalLayoutWithIndex:indexPath];
    [self drawItem:item layout:layout];
}
- (void)reloadItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath{
    [self reloadLayoutWithItem:item atIndexPath:indexPath];
    [self reloadContentWithItem:item atIndexPath:indexPath];
//    NSLog(@"item rect: %@",NSStringFromCGRect(item.frame));
}

/**
 对item 内容的更新

 @param item item
 @param indexPath indexpath
 */
- (void)reloadContentWithItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:drawedObject:indexPath:)]) {
        item = [self.delegate collectionView:self drawedObject:item indexPath:indexPath];
    }else if (self.reloadItem){
        item = _reloadItem(self,item,indexPath);
    }
}
/**
 对item 布局的更新

 @param item item
 @param indexPath indexPath
 */
- (void)reloadLayoutWithItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(layoutsForCollectionView:layout:indexPath:)]) {
        [self drawItem:item layout:[self.delegate layoutsForCollectionView:self layout:[self layout:indexPath] indexPath:indexPath]];
    }else{
        [self drawItem:item layout:[self nomalLayoutWithIndex:indexPath]];
    }
}


- (SBColletionLayout *)nomalLayoutWithIndex:(NSIndexPath*)indexPath{
    SBColletionLayout *layout = [self layout:indexPath];
    layout.frame = [self calculateframeAtIndexPath:indexPath];
    return layout;
}
- (SBColletionLayout *)layout:(NSIndexPath *)indexPath{
    if (!_privateLayout) {
        _privateLayout = [[SBColletionLayout alloc] init];
    }
     [_privateLayout clear];
    _privateLayout.indexPath = indexPath;
   
    return _privateLayout;
}
- (NSInteger)itemCount{
    if ([self.delegate respondsToSelector:@selector(itemsCountForCollectionView:)]) {
        _itemCount = [self.delegate itemsCountForCollectionView:self];
    }else if (self.countItem){
        _itemCount = self.countItem(self);
    }
    return _itemCount;
}
- (NSInteger)countOfRow{
    NSInteger count = 0;
    CGFloat width = screen_width()-self.contentInset.left-self.contentInset.right;
    float pb_float = (width+self.minHorizontalSpace)/(self.itemSize.width+self.minHorizontalSpace);
    count = floor(pb_float);
    NSAssert(count, @"contentInset or size value is wrong");
    if (count == 1) {
        _privateHorizontalSpace = 0;
        return count;
    }
    _privateHorizontalSpace = (width-count*self.itemSize.width)/(count-1);
    return count;
}
- (CGRect)calculateframeAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame;
    CGFloat x = self.contentInset.left+(indexPath.row%_rowCount)*(self.itemSize.width+_privateHorizontalSpace);
    CGFloat y = self.contentInset.top+(indexPath.row/_rowCount)*(self.itemSize.height+self.verticalSpace);
    frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    return frame;
}
/**
 是否允许cache
 @param allowCache allowed
 */
- (void)setAllowCache:(BOOL)allowCache{
    if (!allowCache) {
        [_cacheManager removeItemForKey:__cachekey];
    }else{
        [_cacheManager createItemForKey:__cachekey];
    }
}

/**
 从代理方获取一个新的item

 @return new item
 */
- (UIView *)newItem:(NSIndexPath *)indexPath{
    UIView *item = nil;
    if ([self.delegate respondsToSelector:@selector(collectionView:itemInitAtIndexPath:)]) {
        item = [self.delegate collectionView:self itemInitAtIndexPath:indexPath];
    }else if(self.item){
        item = _item(self,indexPath);
    }
    __weak typeof(self) weak = self;
    item.clickItem = ^(NSIndexPath *indexPath){
        [weak clickItemSelectorWithIndexPath:indexPath];
    };
    if (!item.userInteractionEnabled) {
        item.userInteractionEnabled = YES;
    }
    item.allowClick = ^{
        return _allowClick;
    };
    item.highLight = ^{
        return _selectHighLight;
    };
    NSAssert(item, @"item initialize invalid");
    return item;
}

- (UIView *)itemWithIndexPath:(NSIndexPath *)indexPath{
    
    UIView *item = [self viewWithTag:[self tagWithIndexPath:indexPath]];
    if (item) {
        return item;
    }
    item = [_cacheManager anyObjectForKey:__cachekey];
    if (!item) {
        item = [self newItem:indexPath];
    }
//    [self addSubview:item];
    return item;
}

- (NSInteger)tagWithIndexPath:(NSIndexPath*)indexPath{
    return indexPath.row+__tagbase;
}
- (void)drawItem:(UIView *)item layout:(SBColletionLayout *)layout{
    item.frame = layout.frame;
    item.bounds = layout.bounds;
    item.indexPath = layout.indexPath;
    item.tag = [self tagWithIndexPath:layout.indexPath];
    item.alpha = layout.alpha;
    item.hidden = layout.hidden;
    item.opaque = layout.opaque;
    [self addSubview:item];
}
- (void)clickItemSelectorWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:self didSelectItemAtIndexPath:indexPath];
    }else if (self.didSelectItem){
        self.didSelectItem(self,indexPath);
    }
}
- (void)addSubview:(UIView *)view{
    [super addSubview:view];
}
- (void)willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    [_cacheManager addObject:subview forKey:__cachekey];
}

@end
