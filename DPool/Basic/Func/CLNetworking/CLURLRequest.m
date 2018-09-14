//
//  CLURLRequest.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLURLRequest.h"

#import "CLNetworkManager.h"

@interface CLURLRequest ()

@property (nonatomic, assign) CLRequestMethodType requestMethod;


@end


@implementation CLURLRequest

+ (instancetype)request{
    return [[self alloc]init];
}


- (CLURLRequest *(^)(CLRequestMethodType requestMethod))setMethod{
    return ^CLURLRequest *(CLRequestMethodType requestMethod){
        self.requestMethod = requestMethod;
        return self;
    };
}


@end
