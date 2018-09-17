//
//  DPTabBarModel.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTabBarModel.h"

@implementation DPTabBarModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tabbar_normal_image" : @"unchecked",@"tabbar_selected_image":@"selected",@"title":@"name",@"service":@"model"};
}

- (NSString *)service{

    if(_web_url.length){
        return @"dp_web";
    }

    return _service;
}



@end
