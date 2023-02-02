//
//  HotCourseListRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/2.
//

#import "HotCourseListRequest.h"

@implementation HotCourseListRequest {
    int _type;
}

- (NSString *)requestUrl {
    return @"/spanish/paprika/management/view";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypeGET;
}

- (instancetype)initWithType:(int)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

/// 请求参数
- (nullable id)requestArgument {
    NSMutableDictionary *params = [[super requestArgument] mutableCopy];
    [params setObject:[NSNumber numberWithInt:_type] forKey:@"course_category"];

    return params;
}

@end
