//
//  XMTestModel.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/8.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTestModel.h"
#import "NSObject+YYModel.h"

// 自己写model的时候可以参考，这个《初始化、使用、嵌套》都比较方便
/// ---------------------------------XMTestModel ----------------------------------------------------
@implementation XMTestModel

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict {
    return [XMTestModel yy_modelWithDictionary:dict];
}

/// - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"testId" : @"id"};
}

@end

/// ---------------------------------XMTestModel2  ----------------------------------------------------
@implementation XMTestModel2

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict {
    return [XMTestModel2 yy_modelWithDictionary:dict];
}

/// - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"myId" : @"id", @"modelArr" : @"testArray"};
}

/// 嵌套的时候需要下面这两个方法。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"oneModel": [XMTestModel class], @"modelArr": [XMTestModel class]};
}

@end
