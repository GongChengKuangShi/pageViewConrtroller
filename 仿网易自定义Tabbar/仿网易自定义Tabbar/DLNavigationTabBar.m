//
//  DLNavigationTabBar.m
//  仿网易自定义Tabbar
//
//  Created by xrh on 2017/10/26.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "DLNavigationTabBar.h"
#define DL_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface DLNavigationTabBar ()

@property (nonatomic, strong) UIView *sliderView;
@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UIButton *selectedButton;

@end

@implementation DLNavigationTabBar

- (instancetype)initWithTitles:(NSArray *)titles {
    if (self = [super initWithFrame:CGRectMake(0, 0, DL_ScreenWidth, 44)]) {
        self.buttonNormalTitleColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.41f alpha:1.00f];
        self.buttonSelectedTileColor = [UIColor colorWithRed:0.86f green:0.39f blue:0.30f alpha:1.00f];
        [self setSubViewWithTitles:titles];
    }
    return self;
}

- (void)setSubViewWithTitles:(NSArray *)titles {
    self.buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count ; i++) {
        NSString *titleString = [titles objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:self.buttonNormalTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.buttonSelectedTileColor forState:UIControlStateSelected];
        [button setTitleColor:self.buttonSelectedTileColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [button setTitle:titleString forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
        [button addTarget:self action:@selector(subButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = self.buttonSelectedTileColor;
    [self addSubview:self.sliderView];
    
}

- (void)subButtonSelected:(UIButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self sliderViewAnimationWithButtonIndex:button.tag - 100];
    if (self.didClickAtIndex) {
        self.didClickAtIndex(button.tag - 100);
    }
}

- (void)scrollToIndex:(NSInteger)index {
    self.selectedButton.selected = NO;
    self.buttonArray[index].selected = YES;
    self.selectedButton = self.buttonArray[index];
    [self sliderViewAnimationWithButtonIndex:index];
}

- (void)sliderViewAnimationWithButtonIndex:(NSInteger)buttonIndex {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat buttonX = self.buttonArray[buttonIndex].center.x - (self.width /2);
        self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
    }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.width =  self.frame.size.width / (self.buttonArray.count * 2);
    CGFloat buttonWidth = self.frame.size.width / self.buttonArray.count;
    for (int buttonIndex = 0; buttonIndex < self.buttonArray.count; buttonIndex ++) {
        self.buttonArray[buttonIndex].frame = CGRectMake(buttonIndex * buttonWidth, 0, buttonWidth, 44);
    }
    CGFloat buttonX = self.buttonArray[0].center.x - self.width / 2;
    self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
}

@end
