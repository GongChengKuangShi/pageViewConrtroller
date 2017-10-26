//
//  ViewController.m
//  仿网易自定义Tabbar
//
//  Created by xrh on 2017/10/26.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ViewController.h"
#import "DLNavigationTabBar.h"

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property(nonatomic,strong)DLNavigationTabBar *navigationTabBar;
@property(nonatomic,strong)NSArray<UIViewController *> *subViewControllers;
@end

@implementation ViewController

- (DLNavigationTabBar *)navigationTabBar {
    if (!_navigationTabBar) {
        _navigationTabBar = [[DLNavigationTabBar alloc] initWithTitles:@[@"粉色",@"蓝色",@"绿色"]];
        __weak typeof(self) weakSelf = self;
        [_navigationTabBar setDidClickAtIndex:^(NSInteger index) {
            [weakSelf navigationDidSelectedControllerIndex:index];
        }];
    }
    
    return _navigationTabBar;
}

-(NSArray *)subViewControllers {
    if (!_subViewControllers) {
        UIViewController *controllerOne = [[UIViewController alloc] init];
        controllerOne.view.backgroundColor = [UIColor magentaColor];
        
        UIViewController *controllerTwo = [[UIViewController alloc] init];
        controllerTwo.view.backgroundColor = [UIColor blueColor];
        
        UIViewController *controllerThree = [[UIViewController alloc] init];
        controllerThree.view.backgroundColor = [UIColor greenColor];
        
        self.subViewControllers = @[controllerOne,controllerTwo,controllerThree];
    }
    return _subViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.navigationTabBar;
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[self.subViewControllers.firstObject]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

#pragma mark - UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    
    return [self.subViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    return [self.subViewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];
    [self.navigationTabBar scrollToIndex:index];
    
}


#pragma mark - PrivateMethod
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
