//
//  RootViewController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/15.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "RootViewController.h"
#import "oneViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "YLTools.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [UIColor cyanColor];
    self.tabBar.tintColor =[ UIColor redColor];
    
    oneViewController * oneVC = [[oneViewController alloc] init];
    twoViewController * twovc   = [[twoViewController alloc] init];
    threeViewController * threevc = [[threeViewController alloc] init];
    oneVC.navigationItem.title = @"11";
    twovc.navigationItem.title = @"22";
    threevc.navigationItem.title = @"33";

    
    YLNavigationController * navc1 = [[YLNavigationController alloc] initWithRootViewController:oneVC];
    YLNavigationController * navc2 = [[YLNavigationController alloc] initWithRootViewController:twovc];
    YLNavigationController * navc3 = [[YLNavigationController alloc] initWithRootViewController:threevc];
    navc1.tabBarItem.title = @"1";
    navc2.tabBarItem.title = @"2";
    navc3.tabBarItem.title = @"3";

    self.viewControllers = @[navc1,navc2,navc3];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
