//
//  DLNavigationTabBar.h
//  仿网易自定义Tabbar
//
//  Created by xrh on 2017/10/26.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TabBarDidClickAtIndex)(NSInteger buttonIndex);

@interface DLNavigationTabBar : UIView

@property (copy, nonatomic)TabBarDidClickAtIndex didClickAtIndex;
- (instancetype)initWithTitles:(NSArray *)titles;
- (void)scrollToIndex:(NSInteger)index;
@property(nonatomic,strong)UIColor *sliderBackgroundColor;
@property(nonatomic,strong)UIColor *buttonNormalTitleColor;
@property(nonatomic,strong)UIColor *buttonSelectedTileColor;

@end
