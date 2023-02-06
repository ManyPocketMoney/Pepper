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
    return RequestMethodTypeGET;
}


@end
