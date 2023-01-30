//
//  ANRouterSpec+Pepper.h
//  Pepper
//
//  Created by dong an on 2023/1/5.
//

#import "ANRouterSpec.h"

NS_ASSUME_NONNULL_BEGIN

@interface ANRouterSpec (Pepper)

/// home模块
extern NSString *const KRequestHomeURL;


/// 首页消息列表
extern NSString *const KRequestMessageURL;

/// mine模块
/// 我的
extern NSString *const KRequestMineURL;

@end

NS_ASSUME_NONNULL_END
