//
//  NSURL+NEKEx.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/9.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (NEKEx)

+ (instancetype)urlWithAppStoreID:(NSString *)appId;

- (NSDictionary *)queryParameters;

@end
