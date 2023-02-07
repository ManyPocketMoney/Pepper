//
//  GetConversionTokenRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "GetConversionTokenRequest.h"

@implementation GetConversionTokenRequest

- (NSString *)requestUrl {
    return @"/auth/login?email=hongyun@beijing.com&password=hongyun@beijing.com";
}

- (NSString *)baseUrl {
    return @"http://103.45.249.71:8080";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypePOST;
}

@end
