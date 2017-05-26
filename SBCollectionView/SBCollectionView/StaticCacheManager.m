//
//  StaticCache_Pb.m
//  BayiParents
//
//  Created by qyb on 2017/5/10.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "StaticCacheManager.h"
#import "StaticCacheItem.h"
#import <UIKit/UIKit.h>

static NSString * const methodKey = @"delloc__did__configed";
@interface StaticCacheManager()
@property (strong,nonatomic) NSMutableDictionary *keys;
@property (strong,nonatomic) NSTimer *timer;
@end
@implementation StaticCacheManager
{
    NSString *_shouldDeledeKey;
}
+ (instancetype)shareManager{
    static StaticCacheManager *pb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pb = [[StaticCacheManager alloc] init];
    });
    
    return pb;
}
- (instancetype)init{
    if (self = [super init]) {
        _keys = [NSMutableDictionary new];
        _shouldRemoveAllObjectsOnMemoryWarning = YES;
        _shouldRemoveAllObjectsWhenEnteringBackground = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
- (void)_appDidReceiveMemoryWarningNotification{
    if (_shouldRemoveAllObjectsOnMemoryWarning) {
        [self asyncRemoveAll];
    }
}

- (void)_appDidEnterBackgroundNotification{
    if (_shouldRemoveAllObjectsWhenEnteringBackground) {
        [self asyncRemoveAll];
    }
}
- (void)asyncRemoveAll{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [_keys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            StaticCacheItem *item = obj;
            @synchronized (item) {
                [item  removeAllObject];
            }
            
        }];
    });
}


- (id)anyObjectForKey:(NSString *)key{
    StaticCacheItem *item = [self itemForKey:key];
    id object = [item anyObject];
    if (!object) {
        return nil;
    }
    [item removeObject:object];
    return object;
}
- (void)addObject:(id)object forKey:(NSString *)key{
    StaticCacheItem *item = [self itemForKey:key];
    [item.set addObject:object];
}


/**
 创建一个新的set

 @param key key
 @return 返回nil为重复创建
 */
- (StaticCacheItem *)createItemForKey:(nonnull NSString *)key{
    
    StaticCacheItem *item = [_keys objectForKey:key];
    if (!item) {
        item = [[StaticCacheItem alloc]init];
        [_keys setObject:item forKey:key];
    }
    return item;
}

- (StaticCacheItem *)itemForKey:(NSString *)key{
    return [_keys objectForKey:key];
}


- (BOOL)isExistCacheForKey:(NSString *)key{
    id obj = [_keys objectForKey:key];
    return [obj boolValue];
}


- (BOOL)removeItemForKey:(NSString *)key{
    StaticCacheItem *item = [_keys objectForKey:key];
    if (!item) {
        return NO;
    }
    NSInteger retainCount = [[item valueForKey:@"retainCount"] integerValue];
    if (retainCount <= 2) {
        [_keys removeObjectForKey:key];
        [item removeAllObject];
        item = nil;
        return YES;
    }else{
        return NO;
    }
    
}

- (void)asyncRemoveItemForKey:(NSString *)key compelet:(void(^)(BOOL succss))compelet{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        StaticCacheItem *item = [_keys objectForKey:key];
        if (!item) {
            if (compelet) {
                compelet(NO);
            }
            
        }
        NSInteger retainCount = [[item valueForKey:@"retainCount"] integerValue];
        if (retainCount <= 2) {
            [_keys removeObjectForKey:key];
            @synchronized (item) {
                [item removeAllObject];
            }
            item = nil;
            compelet(YES);
        }else{
            if (compelet) {
                compelet(NO);
            }
        }
    });
    
}


//- (void)deallocSetForKey:(NSString *)key{
//    NSMutableSet *set = [_sets objectForKey:key];
//    [_sets removeObjectForKey:key];
//    set = nil;
//}
@end
