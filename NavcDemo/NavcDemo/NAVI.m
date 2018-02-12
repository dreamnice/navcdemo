//
//  NAVI.m
//  navigation
//
//  Created by 朱力珅 on 2017/6/25.
//  Copyright © 2017年 朱力珅. All rights reserved.
//

//navigation标题

#define FontScale [UIScreen mainScreen].bounds.size.width/720.0

#import "NAVI.h"

@implementation NAVI


- (id)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self AddLine];

    }
    return self;
}

- (void)AddLine{
//    //scrollView1 滚动条
//    self.scrollview1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.0792 *ScreenW, self.frame.size.width, 2.3)];
//    self.scrollview1.contentSize = CGSizeMake(self.frame.size.width *5/3, 2.3);
//    self.scrollview1.backgroundColor = [UIColor clearColor];
//
//    UIView *vieww1 = [[UIView alloc]initWithFrame:CGRectMake(self.scrollview1.contentSize.width *2/5 + 0.0444 *ScreenW , 0, 0.0944 *ScreenW, 2.3)];
//
//    UIView *vieww2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.scrollview1.contentSize.width, 2.3)];
//
//    [vieww2 addSubview:vieww1];
//
//    vieww1.backgroundColor = UIColorFromHex(0xf761b9);
//    vieww1.layer.cornerRadius = 1.15;
//    vieww2.backgroundColor = [UIColor clearColor];
//    [self.scrollview1 addSubview:vieww2];
//
//    self.scrollview1.scrollEnabled = NO;
//    self.scrollview1.showsVerticalScrollIndicator = NO;
//    self.scrollview1.showsHorizontalScrollIndicator = NO;
//    self.scrollview1.bounces = YES;
//    [self.scrollview1 setContentOffset:CGPointMake(self.scrollview1.frame.size.width *2/3, 0) animated:YES];
//
//    [self addSubview:self.scrollview1];
}


- (void)setViewWithTite: (NSArray *)titleArry color:(UIColor *)titleColor buttonArry:(void(^)(NSMutableArray * arry))buttonarry{
    
    NSMutableArray *titlebuttonArry = [NSMutableArray array];
    CGFloat btX = 0;
    CGFloat btW = self.frame.size.width/titleArry.count;
    CGFloat btH = self.frame.size.height;
    
    for (int i = 0; i<titleArry.count; i++) {
        btX = i*btW;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btX, 0, btW, btH);
        //标题
        [button setTitle:titleArry[i] forState:UIControlStateNormal];
        //颜色
        if(i == 0){
            [button setTitleColor:[UIColor colorWithRed:250/255.0 green:86/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
            
        }else{
            [button setTitleColor:[UIColor colorWithRed:250/255.0 green:164/255.0 blue:213/255.0 alpha:1] forState:0];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:32 *FontScale];
        [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        if(i==0){
            _SelectButton = button;
            [self Click:button];
        }
        [titlebuttonArry addObject:button];
        
        [self addSubview:button];
    };
    buttonarry(titlebuttonArry);
}

//点击
- (void)Click:(UIButton *)Btn{

    if([self.delegate respondsToSelector:@selector(onClick:)]){

        [self.delegate onClick:Btn];
    }
}




@end
