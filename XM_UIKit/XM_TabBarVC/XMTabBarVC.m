//
//  XMTabBarVC.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "XMTabBarVC.h"
#import "UIColor+XMTool.h"
#import "XMSizeMacro.h"                 // OC 尺寸相关宏
#import "XMNavigationController.h"

// 商城
#import "ShopVC.h"
/// 自定义的tabbar 按钮
@interface XMTabBarButton : UIButton

@end

@interface XMTabBarVC ()

@end

/// tabbar title默认颜色
#define kTabbar_TitleColor_XM           [UIColor colorFromHexString:@"333d40"]
/// tabbar title选中颜色
#define kTabbar_TitleColor_Sel_XM       [UIColor colorFromHexString:@"#e8320d"]
/// TabBar 背景色
#define kTabBar_bgColor_XM              [UIColor whiteColor]
/// 数字角标直径
#define kNumMark_W_H_XM                 20
/// 小红点直径
#define kPointMark_W_H_XM               8

/// TabBarButton中 图片与文字上下所占比
#define kTabbar_title_img_scale_XM       0.60

@interface XMTabBarButton()<UINavigationControllerDelegate>

@end

@implementation XMTabBarButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = kTabBar_bgColor_XM;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat newX = 0;
    CGFloat newY = 5;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height*kTabbar_title_img_scale_XM-newY;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat newX = 0;
    CGFloat newY = contentRect.size.height*kTabbar_title_img_scale_XM;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height-contentRect.size.height*kTabbar_title_img_scale_XM;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

@end

@interface XMTabBarVC ()

@property (nonatomic, strong) UIButton *seleBtn;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *selImageArray;
@property (nonatomic, strong) NSArray *controllerArray;

@end

@implementation XMTabBarVC

+ (instancetype)defaultManager {
    static XMTabBarVC *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 只能执行一次：这里是单利属性的初始化。
        [self initTabbarVC];
        self.selectedIndex = 0;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)initWithControllerArray:(NSArray *)controllerArray titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray selImageArray:(NSArray *)selImageArray height:(CGFloat )height {
    self.controllerArray =controllerArray;
    self.titleArray = titleArray;
    self.imageArray = imageArray;
    self.selImageArray = selImageArray;
    self.tabBarHeight = height;
}
/// 初始化tabbar的几个页面
- (void)initTabbarVC {
    NSMutableArray *controllerArray = @[@"HomePageVC",@"CourseCategoryVC",@"StudyVC",@"ShopVC",@"NewMineVC"].mutableCopy;
    NSArray * titleArray = @[NSLocalizedString(@"课程", nil),NSLocalizedString(@"分类", nil),NSLocalizedString(@"学习", nil), NSLocalizedString(@"商城", nil),NSLocalizedString(@"我的", nil)];
    NSArray *imageArray= @[@"tabbar_1",@"tabbar_2",@"tabbar_3",@"tabbar_3",@"tabbar_4"];
    //选中图片数组
    NSArray *selImageArray = @[@"tabbar_1_s",@"tabbar_2_s",@"tabbar_3_s",@"tabbar_3_s",@"tabbar_4_s"];
    //初始化(height:最小高度为49.0,当传nil 或<49.0时均按49.0处理)
    [self initWithControllerArray:controllerArray titleArray:titleArray imageArray:imageArray selImageArray:selImageArray height:kTabBarH_XM];
    [self initTabBar];
    [self showControllerIndex:0];
}

-(void)initTabBar {
    //创建VC
    [self createControllerBycontrollerArrayay:self.controllerArray];
    //创建tabBarView
    [self createTabBarView];
    //设置TabbarLine
    [self setTabBarLine];
}

-(void)createControllerBycontrollerArrayay:(NSArray *)controllerArrayay {
    NSMutableArray *tabBarArr = [[NSMutableArray alloc]init];
    for (NSString *className in controllerArrayay) {
        Class class = NSClassFromString(className);
        UIViewController *vc = nil;
        //        if ([Tool vcString_to_ViewController:className]) { // swift类
        //            vc = [Tool vcString_to_ViewController:className];
        //        } else { // OC类
        vc = [[class alloc]init];
        //        }
        //4. 添加nav控制器
        XMNavigationController *nav = [[XMNavigationController alloc] initWithRootViewController:vc];
        [tabBarArr addObject:nav];
    }
    self.viewControllers = tabBarArr;
}
-(void)setTabBarLine {
    if (self.tabBarHeight>= 49.0) {
        [self.tabBar setShadowImage:[[UIImage alloc] init]];
        [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        lineLabel.backgroundColor = [UIColor getSeparatorColor_XM];
        lineLabel.alpha = 0.8;
        [self.tabBarView addSubview:lineLabel];
    }
}

-(void)createTabBarView {
    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,kTabBarH_XM)];
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:self.tabBarView];
    int num = (int)self.controllerArray.count;
    for(int i=0;i<num;i++) {
        XMTabBarButton *button = [[XMTabBarButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/num*i, 0, [UIScreen mainScreen].bounds.size.width/num,kTabBarH_XM - kView_bottom_h_XM)];
        button.tag = 1000+i;
        
        //常态文字颜色
        [button setTitleColor:kTabbar_TitleColor_XM forState:UIControlStateNormal];
        //选中文字颜色
        [button setTitleColor:kTabbar_TitleColor_Sel_XM forState:UIControlStateSelected];
        [button setTitleColor:kTabbar_TitleColor_Sel_XM forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selImageArray[i]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:self.selImageArray[i]] forState:UIControlStateHighlighted];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView  addSubview:button];
        if (i==0) {
            //默认选中
            button.selected=YES;
            self.seleBtn = button;
        }
        //角标
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width/2.0 + 8, 4, kNumMark_W_H_XM, kNumMark_W_H_XM)];
        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 10;
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:13];
        numLabel.tag = 1010+i;
        numLabel.hidden = YES;
        [button addSubview:numLabel];
    }
}
-(void)buttonAction:(UIButton *)button {
    NSInteger index = button.tag-1000;
    if (index == 3) { // 商城
        [XMRouterTool pushVC:[ShopVC new]];
        return;
    }
    [self showControllerIndex:index];
}

/**
 *  切换显示控制器
 *
 *  @param index 位置
 */
-(void)showControllerIndex:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    /// 不登录不让进入的话，可以在这强制return ，弹出登录框
    
    self.seleBtn.selected = NO;
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:1000+index];
    button.selected = YES;
    self.seleBtn = button;
    self.selectedIndex=index;
}
/**
 *  数字角标
 *
 *  @param badge   所要显示数字
 *  @param index 位置
 */
-(void)showBadgeMark:(NSInteger)badge index:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    if(badge<=0) {
        //隐藏角标
        [self hideMarkIndex:index];
    } else {
        if(badge>0&&badge<=9) {
            nFrame.size.width = kNumMark_W_H_XM;
        } else if (badge>9&&badge<=19) {
            nFrame.size.width = kNumMark_W_H_XM+5;
        } else {
            nFrame.size.width = kNumMark_W_H_XM+10;
        }
        nFrame.size.height = kNumMark_W_H_XM;
        numLabel.frame = nFrame;
        numLabel.layer.cornerRadius = kNumMark_W_H_XM/2.0;
        numLabel.text = [NSString stringWithFormat:@"%ld",(long)badge];
        if (badge > 99) {
            numLabel.text =@"99+";
        }
    }
}

/**
 *  小红点
 *
 *  @param index 位置
 */
-(void)showPointMarkIndex:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    nFrame.size.height=kPointMark_W_H_XM;
    nFrame.size.width = kPointMark_W_H_XM;
    numLabel.frame = nFrame;
    numLabel.layer.cornerRadius = kPointMark_W_H_XM/2.0;
    numLabel.text = @"";
}

/**
 *  影藏指定位置角标
 *
 *  @param index 位置
 */
-(void)hideMarkIndex:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden = YES;
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem {
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], NSFontAttributeName,
                                        [UIColor whiteColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem {
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],NSFontAttributeName,
                                        [UIColor getRedColor_XM],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}


@end
