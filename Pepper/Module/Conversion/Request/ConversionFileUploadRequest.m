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
    return [NSString stringWithFormat:@"/upload?handle_type=%@&option=%@",_type,_op];

}

- (NSString *)baseUrl {
    return @"http://103.45.249.71:8080";
}

- (RequestMethodType)requestMethodType {
    return RequestMethodTypePOST;
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
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    return @{@"Authorization":token,
             @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
    };
}

- (instancetype)initWithFilePathURL:(NSURL *)filePathURL {
    if (self = [super init]) {
        _filePathURL = filePathURL;

        _type = @"pdf2word";
        _op = [self convertToJsonData:@{@"data_format":@"doc"}] ;
        
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
