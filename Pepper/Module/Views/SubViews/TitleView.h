//
//  TitleView.h
//  Pepper
//
//  Created by dong an on 2023/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TitleViewClick)(void);

@interface TitleView : UIView

@property (nonatomic, copy) TitleViewClick block;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
