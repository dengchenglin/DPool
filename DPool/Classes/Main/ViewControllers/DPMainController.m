//
//  DPMainController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPMainController.h"

#import "DPTabBarItem.h"

#import "DPTabBarModel.h"

#import "DPNetworkEngine+App.h"

@interface DPMainController ()

@property (nonatomic,  copy) NSArray <DPTabBarModel *>*tabbar_models;

@property (nonatomic,strong) UIView *gc_tabBar;

@property (nonatomic,strong) NSArray <DPTabBarItem *>*tabBarItems;

@end

@implementation DPMainController

- (UIView *)gc_tabBar{
    if(!_gc_tabBar){
        [self.tabBar removeAllSubViews];
        _gc_tabBar = [[UIView alloc]initWithFrame:self.tabBar.bounds];
        _gc_tabBar.backgroundColor = RGBColor(35, 123, 160);
        [self.tabBar addSubview:_gc_tabBar];
    }
    return _gc_tabBar;
}

- (NSArray *)tabbar_plist{
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:[self mainPath]];
    return arr?: @[@{@"unchecked":@"home_normal",@"selected":@"home_selected",@"name":@"首页",@"service":@"dp_home"},
             @{@"unchecked":@"template_normal",@"selected":@"template_selected",@"name":@"控制面板",@"service":@"dp_template"},
             @{@"unchecked":@"set_normal",@"selected":@"set_selected",@"name":@"设置",@"service":@"dp_set"}];
    
}

- (NSArray *)tabbar_models{
    if(!_tabbar_models){
        
        _tabbar_models = [DPTabBarModel yy_modelsWithDatas:[self tabbar_plist]];
    }
    return _tabbar_models;
}

- (NSArray<DPTabBarItem *> *)tabBarItems{
    
    if(!_tabBarItems){
        
        NSMutableArray *tabBarItems = [NSMutableArray array];
        CGFloat width = SCREEN_WIDTH/self.tabbar_models.count;
        [self.tabbar_models enumerateObjectsUsingBlock:^(DPTabBarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            DPTabBarItem *tabBarItem = [[DPTabBarItem alloc]initWithFrame:CGRectMake(idx * width, 0, width, self.gc_tabBar.height)];
            tabBarItem.tag = 100 + idx;
            tabBarItem.image = obj.tabbar_normal_image;
            tabBarItem.selectedImage = obj.tabbar_selected_image;
            tabBarItem.title = obj.title;
            @weakify(self);
            [tabBarItem addTapGestureRecognizerWithBlock:^(id sender) {
                @strongify(self);
                self.selectedIndex = ((DPTabBarItem *)sender).tag - 100;
                
            }];
            [self.gc_tabBar addSubview:tabBarItem];
            
            [tabBarItems addObject:tabBarItem];
        }];
        _tabBarItems = [tabBarItems copy];
        
    }
    return  _tabBarItems;
}

- (NSArray <UIViewController *>*)main_viewControllers{
    return [self.tabbar_models map:^id(NSInteger index, DPTabBarModel* element) {
        Class<CLModuleServiceProtocol> service = [DPModuleServiceManager serviceForStr:element.service];
  
        if(element.web_url.length){
            Class<DPWebServiceProtocol> webService = ( Class<DPWebServiceProtocol>)[DPModuleServiceManager serviceForStr:element.service];
            UIViewController *rootVc = [webService webViewControllerWithUrl:element.web_url title:element.title];
            rootVc.title = element.title;
            return [[UINavigationController alloc]initWithRootViewController:rootVc];
        }

        UIViewController *rootVc = [service rootViewController];
        rootVc.title = element.title;
        return [[UINavigationController alloc]initWithRootViewController:rootVc];
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if(selectedIndex == 1 && ![DPAppManager logined]){
        [DPModuleManager showLoginFromViewController:self callback:^(BOOL result) {
            if(result){
                [self super_selectedIndex:selectedIndex];
            }
        }];
    }
    else{
        [self super_selectedIndex:selectedIndex];
    }
    
}
- (void)super_selectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    [self.tabBarItems enumerateObjectsUsingBlock:^(DPTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (selectedIndex == idx);
        
    }];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self request];
   self.viewControllers = [self main_viewControllers];

}

- (void)request{
    [DPRequest tabbarInfoWithCallback:^(NSArray * data, DPNetError error, NSString *msg) {
        self.tabbar_models = [DPTabBarModel yy_modelsWithDatas:data];
         self.viewControllers = [self main_viewControllers];

        [data writeToFile:[self mainPath] atomically:YES];
    }];
}



//这里彻底删除系统的tabbaritem
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj != self.gc_tabBar){
            [obj removeFromSuperview];
            obj = nil;
        }

    }];
}

#pragma mark -CachesPath

- (NSString *)mainPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"main_info.plist"];
}

@end
