//
//  NSString+Empty.m
//  ZBMOM
//
//  Created by dong an on 2021/2/1.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

/**
 判断字符串是否为空
 
 @param string 字符串
 @return yes 非空  no 空
 */
+ (BOOL)checkStringIsValided:(NSString *)string {
    if (string == nil || string == NULL){
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return NO;
    }
    if ([string isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([string isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([string isEqualToString:@"null"]) {
        return NO;
    }
    return YES;
}

@end
