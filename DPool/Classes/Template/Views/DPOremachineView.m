//
//  DPOremachineView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPOremachineView.h"

@implementation DPOremachineView

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)setModel:(DPTemplateModel *)model{
    _model = model;
    _activeLabel.text = _model.stats.workers_active;
    _unactiveLabel.text = _model.stats.workers_inactive;
    _disabledLabel.text = _model.stats.workers_dead;
}

@end
