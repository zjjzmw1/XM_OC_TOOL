//
//  XMLocationTrans.h
//  艺库
//
//  Created by zhangmingwei on 2019/8/26.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 地图的坐标系之间的转换
@interface XMLocationTrans : NSObject

/// 获取【火星】坐标（GCJ-02） 传入: GPS坐标（WGS-84）
+ (CLLocationCoordinate2D)getMarsFromGPS:(CLLocationCoordinate2D)coordinate;
/// 获取【火星】坐标（GCJ-02） 传入: 百度坐标（BD-09）
+ (CLLocationCoordinate2D)getMarsFromBaidu:(CLLocationCoordinate2D)coordinate;

/// 获取【GPS】坐标（WGS-84） 传入：火星坐标（GCJ-02）
+ (CLLocationCoordinate2D)getGPSFromMars:(CLLocationCoordinate2D)coordinate;
/// 获取【GPS】坐标（WGS-84） 传入：百度坐标（BD-09）
+ (CLLocationCoordinate2D)getGPSFromBaidu:(CLLocationCoordinate2D)coordinate;

/// 获取【百度】坐标（BD-09） 传入：GPS坐标（WGS-84）
+ (CLLocationCoordinate2D)getBaiduFromGPS:(CLLocationCoordinate2D)coordinate;
/// 获取【百度】坐标（BD-09） 传入：火星坐标（GCJ-02）
+ (CLLocationCoordinate2D)getBaiduFromMars:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END
