//
//  XMTest1Model.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/8.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTest1Model.h"
// 利用 YYModel的变量方法
#import <YYModel.h>

/// ---------------------------------XMTest1Model ----------------------------------------------------
@implementation XMTest1Model

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict {
    return [XMTest1Model yy_modelWithDictionary:dict];
}

// - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"myId" : @"id"};
}

@end

/// ---------------------------------XMTest2Model ----------------------------------------------------
/// 举例嵌套的model - test
@implementation XMTest2Model

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict {
    return [XMTest2Model yy_modelWithDictionary:dict];
}

// - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    // - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
    return @{@"tid" : @"id"};
}

/// 嵌套的时候需要下面这两个方法。  ------------------ 不嵌套就不用这个方法
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"baseM": [XMTest1Model class], @"testM": [XMTest1Model class]};
}

@end
