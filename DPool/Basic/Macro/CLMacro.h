//
//  CLDevice.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#ifndef CLMacro_h
#define CLMacro_h

/* 设备信息 */

//系统
#define IOS_8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define IOS_9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define IOS_10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define IOS_11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
#define IOS_11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)

//设备判断
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_iPhone6 ([[UIScreen mainScreen] bounds].size.width == 375)
#define IS_iPhone6s ([[UIScreen mainScreen] bounds].size.width == 414)
#define IS_iPhoneX ([[UIScreen mainScreen] bounds].size.height == 812)

//屏幕尺寸
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

#define AUTO_X  SCREEN_WIDTH/320
#define AUTO_Y  (SCREEN_HEIGHT>480 ? SCREEN_HEIGHT/568 : 1.0)
#define AUTO_FONT ((SCREEN_WIDTH == 320) ? 1 : (AUTO_X * 0.93))

//像素缩放
#define SCREEN_SCALE [UIScreen mainScreen].scale



/**
 * 导航与TabBar
 */
#define NAVBAR_HEIGHT (IS_iPhoneX ? (64 + 24) : 64)
#define TABBAR_HEIGHT (IS_iPhoneX ? (49 + 34) : 49)

/*颜色*/
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

/*字体*/
#define FONT_PFRG_SIZE(s) [UIFont systemFontOfSize:s]

/*线宽*/
#define LINE_WIDTH (1/SCREEN_SCALE)


/* 工具宏 */
//单例
#define SINGLETON_FOR_CLASS_DEF(class)    \
+ (instancetype) sharedInstance;

#define SINGLETON_FOR_CLASS_IMP(class)\
+ (instancetype) sharedInstance    \
{\
static class *instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[class alloc] init];\
});\
return instance;\
}

//view的初始化
#define ViewInstance(setUpName) \
- (instancetype)init{self = [super init];\
if (self) {[self setUpName];}\
return self;}\
- (instancetype)initWithFrame:(CGRect)frame{\
if(self = [super initWithFrame:frame]){[self setUpName];}\
return self;}\
- (void)awakeFromNib{\
[super awakeFromNib];\
[self setUpName];}

#define EnCodingNSString(s) (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)s,NULL,CFSTR("!*’();:@&=+$,/?%#[]"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))


#ifdef DEBUG
#define DBLog(s, ...)    NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DBLog(s, ...) {}
#endif





#endif /* CLDevice_h */
