//
//  ConversionFileUploadRequest.m
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "ConversionFileUploadRequest.h"

@implementation ConversionFileUploadRequest {
    NSURL *_filePathURL;
    NSString *_token;
    NSString *_type;
    NSString *_op;
}

- (NSString *)requestUrl {
    return @"/upload";
}


- (NSString *)baseUrl {
    return @"http://103.45.249.71:8080";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypePOST;
}

/// 请求参数
- (nullable id)requestArgument {
    NSMutableDictionary *params = [[super requestArgument] mutableCopy];
    [params setObject:_type forKey:@"handle_type"];
    [params setObject:_op forKey:@"option"];
    [params setObject:@"WU_FILE_0" forKey:@"id"];
    return params;
}


- (NSURL *)filePathURL {
    return _filePathURL;
}


- (NSString *)mediaName {
    return @"file";
}

/// 设置请求头
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSString *token = [UserDefaultUtil userDefaultsObject:@"token"];
    if (!token) {
        token = @"";
    }
    return @{@"Authorization":token};
}

- (instancetype)initWithFilePathURL:(NSURL *)filePathURL type:(NSString *)type format:(NSString *)format {
    if (self = [super init]) {
        _filePathURL = filePathURL;

        _type = type;
        _op = [self convertToJsonData:@{@"data_format":format}];
        
    }
    return self;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

@end
