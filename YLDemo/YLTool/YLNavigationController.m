//
//  YLNavigationController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLNavigationController.h"
#import "YLTools.h"

@interface YLNavigationController ()

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.automaticallyAdjustsScrollViewInsets = NO;

    //导航栏上内容颜色。貌似只改变了返回按钮的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    //导航栏上字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self naviBarIsHidden:NO];

}


- (void)naviBarIsHidden:(BOOL)isHidden
{
    //状态栏背景色view
    UIView * statusBarV = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if(isHidden)
    {
        statusBarV.backgroundColor = [UIColor clearColor];
        //状态栏字体颜色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        
        self.navigationBar.translucent = YES;
        //导航栏颜色
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationBarHidden = YES;
    }
    else
    {
        statusBarV.backgroundColor = [UIColor blueColor];
        //状态栏字体颜色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        
        self.navigationBar.translucent = NO;
        //导航栏颜色
        [self.navigationBar setBackgroundImage:[[UIColor blueColor] colorToImage] forBarMetrics:UIBarMetricsDefault];
        self.navigationBarHidden = NO;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >1)
    {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}

-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStyleDone target:self action:@selector(clickBackBut)];
}


-(void)clickBackBut
{
    [self popViewControllerAnimated:YES];
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
