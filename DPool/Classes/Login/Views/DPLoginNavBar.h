//
//  DPLoginNavBar.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPLoginNavBar : UIView

@property (nonatomic, copy) NSString *title;

+ (DPLoginNavBar *)navBar;

- (void)addBackTarget:(id)target selector:(SEL)selector;

@end
