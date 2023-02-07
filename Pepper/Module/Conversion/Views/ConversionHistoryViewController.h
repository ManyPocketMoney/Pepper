//
//  ConversionHistoryViewController.h
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversionHistoryViewController : BaseViewController

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSURL *fileUrl;

@end

NS_ASSUME_NONNULL_END
