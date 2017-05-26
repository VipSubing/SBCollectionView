//
//  StaticCacheItem.m
//  BayiParents
//
//  Created by qyb on 2017/5/11.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "StaticCacheItem.h"
//#import "AvoidCrash.h"

@interface StaticCacheItem()
@property (strong,nonatomic,readwrite) NSMutableSet *set;

@end

@implementation StaticCacheItem
- (instancetype)init{
    if (self = [super init]) {
        _set = [NSMutableSet set];
    }
    return self;
}
#pragma mark       set func
- (NSInteger)setOfCount{
    return _set.count;
}
- (id)anyObject{
    return [_set anyObject];
}
- (void)removeAllObject{
    [_set removeAllObjects];
}

- (void)removeObject:(id)object{
    [_set removeObject:object];
}
- (void)addObject:(id)object{
    [_set addObject:object];
}
- (NSArray *)allObject{
    return [_set allObjects];
}
- (void)dealloc{
    
}
#pragma mark       observer func
//- (void)setObserver_pb:(id)observer_pb{
//    _observer_pb = observer_pb;
//    SEL deallocSelector = sel_registerName("dealloc");
//    [AvoidCrash exchangeInstanceMethod:[observer_pb class] method1Sel:deallocSelector method2Sel:@selector(automaticRelease)];
//}



@end
