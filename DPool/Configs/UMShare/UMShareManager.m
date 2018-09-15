//
//  UMShareManager.m
//  DPool
//
//  Created by dengchenglin on 2018/9/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UMShareManager.h"

#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "UMSocialQQHandler.h"
#import <UShareUI/UShareUI.h>
#import "UMSocialWechatHandler.h"

#import <YTXModule/YTXModule.h>

@interface ShareInfo : NSObject

@property (nonatomic, copy) NSString *img_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *link_url;

@end

@implementation ShareInfo

@end

@implementation UMShareManager

YTXMODULE_EXTERN()
{
    
}

+ (void)config{
    [UMConfigure initWithAppkey:@"58edd022f29d9826f000139e" channel:@"App Store"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina)]];
}



+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


+ (void)shareInfo:(NSDictionary *)info{
    
    ShareInfo *shareInfo = [ShareInfo yy_modelWithDictionary:info];
    if(!shareInfo){
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"分享信息出错" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象

    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareInfo.title descr:shareInfo.content thumImage:shareInfo.img_url];
    shareObject.webpageUrl = shareInfo.link_url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {


        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIUtil getCurrentViewController] completion:nil];
    }];
}

@end


