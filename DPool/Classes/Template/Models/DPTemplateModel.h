//
//  DPTemplateModel.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History :NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *share;
@property (nonatomic, copy) NSString *reject;
@end


@interface Stats :NSObject
@property (nonatomic, copy) NSString *workers_active;
@property (nonatomic, copy) NSString *workers_inactive;
@property (nonatomic, copy) NSString *workers_dead;
@property (nonatomic, copy) NSString *shares_1m;
@property (nonatomic, copy) NSString *shares_5m;
@property (nonatomic, copy) NSString *shares_15m;
@property (nonatomic, copy) NSString *shares_1h;
@property (nonatomic, copy) NSString *shares_24h;
@property (nonatomic, copy) NSString *shares_unit;
@end

@interface Payment :NSObject
@property (nonatomic, copy) NSString *yesterdayearn;
@property (nonatomic, copy) NSString *per;
@property (nonatomic, copy) NSString *earn;
@property (nonatomic, copy) NSString *pay_amount;
@property (nonatomic, copy) NSString *total_earn;
@end

@interface DPTemplateModel : NSObject

@property (nonatomic, copy) NSArray<History *> *history_h;

@property (nonatomic, copy) NSArray<History *> *history_d;

@property (nonatomic, strong) Payment *payment;

@property (nonatomic, strong) Stats *stats;

@end
