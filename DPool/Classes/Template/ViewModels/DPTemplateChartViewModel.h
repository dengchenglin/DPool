//
//  DPTemplateChartViewModel.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPViewModel.h"

#import "DPTemplateModel.h"

#define DPTEMPLATECHART_HORIZONAL_ITEM_WIDTH   50.0

#define DPTEMPLATECHART_VERTICAL_LEVEL       5

#define DPTEMPLATECHART_VERTICAL_HGIGHT      250.0

#define DPTEMPLATECHART_VERTICAL_ITEM_HGIGHT 32

#define DPTEMPLATECHART_HORIZONAL_MAX_WIDTH  (SCREEN_WIDTH - 100.0)


@interface HorizontalInfo :NSObject

@property (nonatomic, assign) CGPoint point;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *share;

@end

@interface DPTemplateChartViewModel : DPViewModel

@property (nonatomic, copy) NSArray <NSString *>* verticals;

@property (nonatomic, copy) NSArray <HorizontalInfo *>* horizontals;

@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, assign) CGFloat titleMaxWidth;

@property (nonatomic, assign) CGFloat verticalMaxheight;

+ (DPTemplateChartViewModel *)viewModelWithModels:(NSArray <History *> *)models;

@end
