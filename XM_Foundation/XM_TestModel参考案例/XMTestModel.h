//
//  XMTestModel.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/8.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 自己写model的时候可以参考，这个《初始化、使用、嵌套》都比较方便
/// ---------------------------------XMTestModel ----------------------------------------------------
@interface XMTestModel : NSObject

/// 例如： id
@property (nonatomic, strong) NSString      *testId;
/// 例如： 名称
@property (nonatomic, strong) NSString      *name;
/// 例如：年龄
@property (nonatomic, assign) int           age;

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

/// ---------------------------------XMTestModel2  ----------------------------------------------------
/// 举例嵌套的model - test
@interface XMTestModel2 : NSObject

/// id
@property (nonatomic, strong) NSString                    *myId;
/// 嵌套的model数组
@property (nonatomic, strong) NSArray<XMTestModel *>      *modelArr;
/// 嵌套的单独一个model
@property (nonatomic, strong) XMTestModel                 *oneModel;

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
