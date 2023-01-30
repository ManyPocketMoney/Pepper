//
//  NavigationView.h
//  Pepper
//
//  Created by dong an on 2023/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NavigationClick)(int i);

@interface NavigationView : UIView

@property (nonatomic, copy) NavigationClick clickBlock;

@end

NS_ASSUME_NONNULL_END
