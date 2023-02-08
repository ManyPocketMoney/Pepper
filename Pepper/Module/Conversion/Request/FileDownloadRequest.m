//
//  FileDownloadRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/8.
//

#import "FileDownloadRequest.h"

@implementation FileDownloadRequest {
    NSString *_type;
    NSString *_fileKey;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat: @"/download?file_key=%@&handle_type=%@",_fileKey,_type];
}

- (NSString *)baseUrl {
    return @"http://103.45.249.71:8080";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypeGET;
}

- (instancetype)initWithType:(NSString *)type fileKey:(NSString *)fileKey  {
    if (self = [super init]) {

        _type = type;
        _fileKey = fileKey;
        
    }
    return self;
}

@end
