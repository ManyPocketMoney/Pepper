//
//  ConversionFileUploadRequest.h
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversionFileUploadRequest : BaseRequest

- (instancetype)initWithFilePathURL:(NSURL *)filePathURL type:(NSString *)type format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
