//
//  threeViewController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/15.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "threeViewController.h"
#import "YLTools.h"
#import "xxView.h"

@interface threeViewController ()
{
    xxView * xx;
}
@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
    UIView * bgv = [[UIView alloc] initWithFrame:CGRectMake(30*k_width_scale, 30*k_width_scale, self.view.width-60*k_width_scale, k_screen_height-[YLTools getNavigationHeight]-[YLTools getTabBarHeight]-60*k_width_scale)];
    bgv.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bgv];
    
    
    xx = [[[NSBundle mainBundle] loadNibNamed:@"xxView" owner:self options:nil] firstObject];
    [self.view addSubview:xx];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    xx.frame = CGRectMake(30*k_width_scale, 30*k_width_scale, self.view.width-60*k_width_scale, k_screen_height-[YLTools getNavigationHeight]-[YLTools getTabBarHeight]-60*k_width_scale);

    
    NSLog(@"%@",NSStringFromCGRect(xx.baibgv.frame));
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
