//
//  HotCourseRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/1.
//

#import "HotCourseRequest.h"

@implementation HotCourseRequest

- (NSString *)requestUrl {
    return @"/spanish/paprika/management/hot";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypePOST;
}

/// 请求参数
- (nullable id)requestArgument {
    NSMutableDictionary *params = [[super requestArgument] mutableCopy];
    [params setObject:[NSNumber numberWithInt:999] forKey:@"limit"];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"currPage"];


    return params;
}

@end
