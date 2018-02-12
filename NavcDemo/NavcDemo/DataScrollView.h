//
//  DataScrollView.h
//  navigation
//
//  Created by 朱力珅 on 2017/6/25.
//  Copyright © 2017年 朱力珅. All rights reserved.
//

#define ScreenW [UIScreen mainScreen].bounds.size.width

#define ScreenH [UIScreen mainScreen].bounds.size.height

#define FontScale [UIScreen mainScreen].bounds.size.width/720.0

#import <UIKit/UIKit.h>


@interface DataScrollView : UIScrollView

- (void)setScrollview:(NSInteger)count;

@end
