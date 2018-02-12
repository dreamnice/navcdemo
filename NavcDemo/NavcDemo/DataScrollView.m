//
//  DataScrollView.m
//  navigation
//
//  Created by 朱力珅 on 2017/6/25.
//  Copyright © 2017年 朱力珅. All rights reserved.
//

#import "DataScrollView.h"


@implementation DataScrollView


- (void)setScrollview:(NSInteger)count{
    //设置滚动区域
    self.contentSize = CGSizeMake(ScreenW*count, 0);
    //设置颜色
    self.backgroundColor = [UIColor whiteColor];
    //设置scrollview属性
    //分页
    self.pagingEnabled = YES;
    //弹簧
    self.bounces = NO;
    //指示器
    self.showsHorizontalScrollIndicator = NO;
}



@end
