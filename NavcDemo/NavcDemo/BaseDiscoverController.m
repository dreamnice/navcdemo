//
//  BaseDiscoverController.m
//  Qunhai
//
//  Created by 朱力珅 on 2017/7/20.
//  Copyright © 2017年 张辉耀. All rights reserved.
//

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define KIsIos11 @available(iOS 11.0, *)



#import "BaseDiscoverController.h"
#import "NAVI.h"
#import "DataScrollView.h"

@interface BaseDiscoverController ()<NAVIDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NAVI *TitleView;

@property (nonatomic, strong) DataScrollView *DataScroll;

@property (nonatomic ,strong)NSMutableArray <UIViewController *>*controllers;

@property (nonatomic ,strong)NSMutableArray *titleArray;


@property (nonatomic, strong) __block NSMutableArray  *buttonarry;


@end

@implementation BaseDiscoverController

- (id)initWithViewControllers:(NSArray<UIViewController *> *)ViewControllers titleArray:(NSArray *)titleArray{
    if([super init]){
        self.controllers = [ViewControllers mutableCopy];
        self.titleArray = [titleArray mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllChildViewController];
    [self setScoroView];
    [self setview];
    
    //注册通知 双击tabbar时刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadChildVC) name:@"ReloadDiscovery" object:nil];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadDiscovery" object:nil];
}


//添加子界面
- (void)setAllChildViewController{
    
    for(UIViewController *vc in _controllers){
        [self addChildViewController:vc];
    }
    
}

- (void)setScoroView{
    if(KIsiPhoneX){
        _DataScroll = [[DataScrollView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 88)];
    }else{
        _DataScroll = [[DataScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    }
    if(KIsIos11){
        _DataScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    //内容往下移动,ios7以后,导航控制器中Scrollview顶部会自动添加64的额外滚动区域
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    _DataScroll.delegate = self;
    [_DataScroll setScrollview:self.childViewControllers.count];
    [self.view addSubview:_DataScroll];
    
    
}

- (void)setview{
    _TitleView = [[NAVI alloc] initWithFrame:CGRectMake(0, 0, 0.5458 *ScreenW, 0.0958 *ScreenW)];
    _TitleView.delegate = self;
    __weak __typeof(self)weakSelf = self;
    [_TitleView setViewWithTite:_titleArray color:_titleColor buttonArry:^(NSMutableArray *arry) {
        weakSelf.buttonarry = arry;
    }];
    self.navigationItem.titleView = _TitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    //侧滑有效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}





//选中标题
- (void)selectTitle: (UIButton *)btn{
    _TitleView.SelectButton.transform = CGAffineTransformIdentity;
    [_TitleView.SelectButton setTitleColor:[UIColor colorWithRed:250/255.0 green:164/255.0 blue:213/255.0 alpha:1]  forState:UIControlStateNormal];
    [btn  setTitleColor:[UIColor colorWithRed:250/255.0 green:86/255.0 blue:213/255.0 alpha:1]  forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    NSInteger i = _DataScroll.contentOffset.x/ScreenW;
    _TitleView.SelectButton  = btn;
    
}





//添加一个子控制器的View
- (void)addOneChildController: (NSInteger)i {
    UIViewController *vc = self.childViewControllers[i];
    //若加载完结束
    if(vc.view.superview){
        return;
    }
    CGFloat x = i * ScreenW;
    vc.view.frame = CGRectMake(x, 0, ScreenW, self.DataScroll.bounds.size.height);
    
    [self.DataScroll addSubview:vc.view];
}

#pragma mark - NAVIDelegate

- (void)onClick:(UIButton *)button{
    //获取角标
    NSInteger i = button.tag;
    NSLog(@"%ld",button.tag);
    //选中标题变色
    [self selectTitle:button];
    //添加对应View
    [self addOneChildController:i];
    //滚动到对应视图
    CGFloat x = i * ScreenW;
//    self.DataScroll.contentOffset = CGPointMake(x, 0);
    [self.DataScroll setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1.获取角标
    NSInteger i = _DataScroll.contentOffset.x/ScreenW;
    UIButton *titlebutton = self.buttonarry[i];
    //2.选中标题
    [self selectTitle:titlebutton];
    //3添加控制器view
    [self addOneChildController:i];
    
}

//只要一滚动就需要字体渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //字体缩放 1.缩放比例 2.缩放哪两个按钮
    
    //获取左边按钮
    NSInteger leftI = scrollView.contentOffset.x/ScreenW;
    UIButton *legtbtn = self.buttonarry[leftI];
    
    //获取右边按钮
    UIButton *rightbtn;
    NSInteger rightI = leftI + 1;
    if(rightI < self.buttonarry.count){
        rightbtn = self.buttonarry[rightI];
    }
    
    //缩放比例 0~1 至 1~1.2
    CGFloat scaleR = scrollView.contentOffset.x/ScreenW;
    scaleR -=leftI;
    CGFloat scaleL = 1 - scaleR;

    legtbtn.transform = CGAffineTransformMakeScale(scaleL*0.2 + 1, scaleL*0.2 +1);
    rightbtn.transform = CGAffineTransformMakeScale(scaleR*0.2 + 1, scaleR*0.2 +1);
    
    
    //颜色渐变
    UIColor *lcolor = [UIColor colorWithRed:250/255.0 green:(86+ scaleR*78)/255.0 blue:213/255.0 alpha:1];
    UIColor *rcolor = [UIColor colorWithRed:250/255.0 green:(164 - scaleR*78)/255.0 blue:213/255.0 alpha:1];
    [legtbtn setTitleColor:lcolor forState:UIControlStateNormal];
    [rightbtn setTitleColor:rcolor forState:UIControlStateNormal];
    
    //滚动条跟随
    [self.TitleView.scrollview1 setContentOffset:CGPointMake(self.TitleView.scrollview1.frame.size.width*2/3 - scrollView.contentOffset.x *self.TitleView.scrollview1.frame.size.width/3 /ScreenW, 0) animated:NO];
    
}


#pragma mark - 双击刷新
- (void)ReloadChildVC{
    NSInteger SelectVC = self.DataScroll.contentOffset.x/ScreenW;
}

- (NSMutableArray <UIViewController *>*)controllers{
    if(!_controllers){
        _controllers = [NSMutableArray array];
    }
    return _controllers;
}

- (NSMutableArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

@end
