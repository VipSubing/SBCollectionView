//
//  StaticCacheItem.h
//  BayiParents
//
//  Created by qyb on 2017/5/11.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticCacheItem : NSObject
@property (strong,nonatomic,readonly) NSMutableSet *set;

- (NSInteger)setOfCount;
- (id)anyObject;
- (void)removeAllObject;
- (void)removeObject:(id)object;
- (void)addObject:(id)object;
- (NSArray *)allObject;

@end
