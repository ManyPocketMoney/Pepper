//
//  TopicRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/6.
//

#import "TopicRequest.h"

@implementation TopicRequest

- (NSString *)requestUrl {
    return @"/spanish/paprika/special/view";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypeGET;
}

@end
