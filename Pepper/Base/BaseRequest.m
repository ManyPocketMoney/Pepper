//
//  BaseRequest.m
//  ZBMOM
//
//  Created by andong on 2021/1/19.
//

#import "BaseRequest.h"
#import "NSString+Empty.h"


#define RequestSuccessCode   200
#define RequestLogAgainCode  399

/// 网络请求基类
@implementation BaseRequest

/// 设置baseUrl
- (NSString *)baseUrl {
    return @"http://59.110.169.244:10110/docs/api-docs.json";
}

/// 设置基本参数
- (id)requestArgument {
    NSMutableDictionary *params = [[super requestArgument] mutableCopy];
    return params;
}

/// 设置请求头
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
//    if ([ZBUserManager token]) {
//        return @{@"token":[ZBUserManager token]};
//    }
    return nil;
}

/// 请求成功后回调统一配置
- (void)successWithResponse:(id)response success:(void (^)(id _Nonnull))success error:(void (^)(void))error {
#ifdef DEBUG
    /// debug时数据输出日志
    NSLog(@"\nurl:%@%@\nparams:%@\nheaders:%@\nbody:%@",[self baseUrl],[self requestUrl],[self requestArgument],[self requestHeaderFieldValueDictionary],response);
#else
#endif
    int code = [response[@"code"] intValue];
    if (code == RequestSuccessCode) {
        /// 请求成功
        success(response);
    } else {
        /// 服务器返回错误
        error();
        if (self.errorCode) {
            self.errorCode(code);
        }
        [self showMsgWithCode:code msg:response[@"msg"]?:response[@"message"]];
    }
}

/// 网路请求失败后统一回调配置
- (void)errorWithResponse:(NSError *)error failure:(void (^)(NSString * _Nonnull))failure {
    NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSString * text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
#ifdef DEBUG
    /// debug时数据输出日志
    NSLog(@"\nurl:%@%@\nparams:%@\nheaders:%@\nbody:%@",[self baseUrl],[self requestUrl],[self requestArgument],[self requestHeaderFieldValueDictionary],error);
#else
#endif
    if ([NSString checkStringIsValided:text]) {
        NSDictionary *dic = [BaseRequest dictionaryWithJsonString:text];
        NSString *message = @"服务器连接失败";
        if ([NSString checkStringIsValided:dic[@"message"]]) {
            message = dic[@"message"];
        }
        if ([NSString checkStringIsValided:dic[@"msg"]]) {
            message = dic[@"msg"];
        }
        text = [NSString stringWithFormat:@"错误码%@，%@",dic[@"code"]?:dic[@"status"],message];
    } else {
        text = error.localizedDescription;
    }
    [ProgressHUDManager showHUDAutoHiddenWithError:text];
    failure(@"请求失败");
}

- (void)showMsgWithCode:(int)code msg:(NSString *)msg {
    /// 如果为重新登录 弹出重新登录框 否则直接提示错误原因
    if (code == RequestLogAgainCode) {
        [ProgressHUDManager dissmissHUDDirect];
        /// 如果当前窗口存在弹框 则直接跳过
        if ([[NSObject currentActiveController] isKindOfClass:[UIAlertController class]]) {
            return;
        }
        /// 登录失效状态
        [ANAlert alertShowWithParams:^(ANAlert * _Nonnull alert) {
            alert.title(@"登录失效").actionTitles(@[@"重新登录"]);
        } handler:^(int index) {
            /// 退出登录
//            [ZBUserManager clear];
            Class class = NSClassFromString(@"ZBLoginViewController");
            if (class) {
              UIViewController *ctrl = class.new;
              UIApplication.sharedApplication.delegate.window.rootViewController = ctrl;
            }
        }];
        return;
    }
    if ([NSString checkStringIsValided:msg]) {
        /// 服务器正常返回错误显示
        [ProgressHUDManager showHUDAutoHiddenWithText:msg];
    } else {
        /// 服务器异常报错显示
        [ProgressHUDManager showHUDAutoHiddenWithText:[NSString stringWithFormat:@"错误码%d, 服务器连接失败",code]];
    }
}

/**
 json字符串转字典

 @param jsonString 字符串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
  if (jsonString == nil) {
    return nil;
  }
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *err;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
  if(err) {
    NSLog(@"json解析失败：%@",err);
    return nil;
  }
  return dic;
}

@end
