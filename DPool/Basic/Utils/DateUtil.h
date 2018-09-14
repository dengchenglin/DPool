//
//  DateUntil.h
//  GeihuiDemo
//
//  Created by peikua on 17/3/23.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

// 根据指定时间字符串返回对应的NSDate。
+ (NSDate *)getDateFromString:(NSString *)aTimeString;

// 根据指定的NSDate返回对应格式的NSString
+ (NSString *)getTimeStringFromDate:(NSDate *)aDate;

//根据指定得时间戳返回对应的时间字符串
+(NSString *)getTimeStringFromDateTimestamp:(NSString *)timestamp;

// 获得当前时间。
+ (NSString *)getNowDate;

//获取当天年月日
+ (NSString *)getDayDate;

// 获得当前时间戳
+ (NSString *)getNowDateTimestamp;

//获取星期
+ (NSString *)getWeekdayForDate:(NSDate *)date;


@end
