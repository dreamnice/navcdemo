//
//  NAVI.h
//  navigation
//
//  Created by 朱力珅 on 2017/6/25.
//  Copyright © 2017年 朱力珅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NAVIDelegate <NSObject>


- (void)onClick: (UIButton *)button;



@end

@interface NAVI : UIView


- (void)setViewWithTite: (NSArray *)titleArry color:(UIColor *)titleColor buttonArry:(void(^)(NSMutableArray * arry))buttonarry;


@property (nonatomic, strong) UIButton *SelectButton;

@property (nonatomic , strong)UIScrollView *scrollview1;

@property (nonatomic, weak)id<NAVIDelegate> delegate;


@end
