//
//  HotView.h
//  Pepper
//
//  Created by dong an on 2023/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HotViewBlock)(int type);

@interface HotView : UIView

@property (nonatomic, copy) HotViewBlock block;

@end

NS_ASSUME_NONNULL_END
