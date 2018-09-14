//
//  CLURLRequest.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLRequest.h"

@interface CLURLRequest : CLRequest

@property (nonatomic, assign, readonly) CLRequestMethodType requestMethod;

+ (instancetype)request;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (CLURLRequest *(^)(CLRequestMethodType requestMethod))setMethod;

@end
