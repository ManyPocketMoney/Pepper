//
//  SearchView.h
//  Pepper
//
//  Created by dong an on 2023/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearchClick)(void);

@interface SearchView : UIView

@property (nonatomic, copy) SearchClick clickBlock;

@end

NS_ASSUME_NONNULL_END
