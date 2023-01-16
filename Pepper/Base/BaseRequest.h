//
//  BaseRequest.h
//  ZBMOM
//
//  Created by andong on 2021/1/19.
//

#import "ANHTTPRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ErrorCodeBlock)(int code);

@interface BaseRequest : ANHTTPRequest

@property (nonatomic, copy) ErrorCodeBlock errorCode;

@end

NS_ASSUME_NONNULL_END
