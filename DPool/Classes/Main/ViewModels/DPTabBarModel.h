//
//  DPTabBarModel.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPTabBarModel : NSObject

/**
 * service
 */
@property (nonatomic, copy) NSString *service;
/**
 * vc标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * tabbar图标
 */
@property (nonatomic, copy) NSString *tabbar_normal_image;
/**
 * tabbar选中图标
 */
@property (nonatomic, copy) NSString *tabbar_selected_image;
/**
 * vc参数
 */
@property (nonatomic, strong) id parm;

/**
 * 用于替换的原生的webUrl
 */
@property (nonatomic, copy) NSString *web_url;

@end
