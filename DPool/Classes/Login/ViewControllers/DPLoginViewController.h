//
//  DPLogigViewController.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginBaseViewController.h"

@interface DPLoginViewController : DPLoginBaseViewController

@property (nonatomic, copy)void(^callback)(BOOL result);

@end
