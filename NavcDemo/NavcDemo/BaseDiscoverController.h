//
//  BaseDiscoverController.h
//  Qunhai
//
//  Created by 朱力珅 on 2017/7/20.
//  Copyright © 2017年 张辉耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDiscoverController : UIViewController

- (id)initWithViewControllers:(NSArray <UIViewController *>*)ViewControllers titleArray:(NSArray *)titleArray;;

@property (nonatomic ,strong)UIColor *titleColor;

@end
