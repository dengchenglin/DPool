//
//  DPTemplateChartViewModel.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateChartViewModel.h"

@implementation HorizontalInfo

@end

@implementation DPTemplateChartViewModel

+ (DPTemplateChartViewModel *)viewModelWithModels:(NSArray <History *> *)models{
    if(!models.count)return nil;
    DPTemplateChartViewModel *viewModel = [DPTemplateChartViewModel new];
    viewModel.itemHeight = DPTEMPLATECHART_VERTICAL_ITEM_HGIGHT;
    viewModel.itemWidth = DPTEMPLATECHART_HORIZONAL_ITEM_WIDTH;
    if(DPTEMPLATECHART_HORIZONAL_ITEM_WIDTH * models.count < DPTEMPLATECHART_HORIZONAL_MAX_WIDTH){
        viewModel.itemWidth = DPTEMPLATECHART_HORIZONAL_MAX_WIDTH/models.count;
    }
    __block NSMutableArray *horizontals = [NSMutableArray array];
    __block CGFloat maxShare = 0;
    [models enumerateObjectsUsingBlock:^(History * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *date = [DateUtil getTimeStringFromDateTimestamp:obj.time];
        HorizontalInfo *info = [HorizontalInfo new];
        info.title = date;
        info.share = obj.share;
        [horizontals addObject:info];
        if( obj.share.floatValue > maxShare){
            maxShare = obj.share.floatValue;
            
        }
    }];
    
    NSUInteger shareLevel = 10;
    while (shareLevel < maxShare) {
        shareLevel *= 10;
    }
    shareLevel /= 10;
    
    maxShare = [@(maxShare) integerValue]/shareLevel * shareLevel  + shareLevel;

    
    CGSize size = [[NSString stringWithFormat:@"%.0f",maxShare] sizeWithFont:[UIFont systemFontOfSize:8] constrainedToSize:CGSizeMake(200, 10)];
    if(size.width < 30){
        size.width = 30;
    }
    viewModel.titleMaxWidth = size.width + 1;
    
    CGFloat step = maxShare/DPTEMPLATECHART_VERTICAL_LEVEL;
    
    
    NSMutableArray *verticals = [NSMutableArray array];
    for(int i =0 ;i <= DPTEMPLATECHART_VERTICAL_LEVEL;i ++){
        [verticals addObject:[NSString stringWithFormat:@"%ld",@(step * i).integerValue]];
    }
    viewModel.verticals = verticals;
    
    
    [horizontals enumerateObjectsUsingBlock:^(HorizontalInfo * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = idx * viewModel.itemWidth;
        CGFloat y = DPTEMPLATECHART_VERTICAL_HGIGHT * (obj.share.floatValue/maxShare);
        obj.point = CGPointMake(x, y);
    }];
    
    viewModel.horizontals = horizontals;
    
    viewModel.contentSize = CGSizeMake(viewModel.itemWidth * models.count, DPTEMPLATECHART_VERTICAL_HGIGHT);
    
    return viewModel;
}

@end
