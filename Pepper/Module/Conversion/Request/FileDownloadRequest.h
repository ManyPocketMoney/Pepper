//
//  FileDownloadRequest.h
//  Pepper
//
//  Created by dong an on 2023/2/8.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileDownloadRequest : BaseRequest

- (instancetype)initWithType:(NSString *)type fileKey:(NSString *)fileKey;

@end

NS_ASSUME_NONNULL_END
