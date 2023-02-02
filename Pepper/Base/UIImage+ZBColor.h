//
//  UIImage+ZBColor.h
//  ZBMOM
//
//  Created by dong an on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZBColor)

/// 颜色转图片
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
