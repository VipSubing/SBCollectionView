//
//  StaticCache_Pb.h
//  BayiParents
//
//  Created by qyb on 2017/5/10.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StaticCacheItem;
@interface StaticCacheManager : NSObject
+ (instancetype)shareManager;


- (id)anyObjectForKey:(NSString *)key;

- (void)addObject:(id)object forKey:(NSString *)key;


/**
 创建一个新的set
 
 @param key key
 @return 返回nil为重复创建
 */
- (StaticCacheItem *)createItemForKey:(nonnull NSString *)key;
/**
 缓存是否存在

 @param key key
 @return yes or no
 */
- (BOOL)isExistCacheForKey:(NSString *)key;
/**
 同步通过key删除set 引用计数不唯一是不成功
 @param key key
 */
- (BOOL)removeItemForKey:(NSString *)key;

/**
 异步清除set

 @param key key
 @param compelet 回调
 */
- (void)asyncRemoveItemForKey:(NSString *)key compelet:(void(^)(BOOL succss))compelet;
/**
 If `YES`, the cache will remove all objects when the app receives a memory warning.
 The default value is `YES`.
 */
@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

/**
 If `YES`, The cache will remove all objects when the app enter background.
 The default value is `YES`.
 */
@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;
@end
