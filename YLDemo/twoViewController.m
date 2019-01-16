//
//  twoViewController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/15.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "twoViewController.h"
#import "YLTools.h"
@interface twoViewController ()
{
    NSInteger _page;
    UIPageControl * pa;
    YLPageControl * pagec;
}
@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _page = 0;
//    YLTextView * tv =[[ YLTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 400)];
//    tv.textColor = [UIColor redColor];
//    tv.font = [UIFont systemFontOfSize:20];
//    tv.placeholderL.text = @"hahha";
//    tv.placeholderL.textColor = [UIColor darkGrayColor];
//    tv.font = tv.font;
//    [self.view addSubview:tv];
    
    pagec = [[YLPageControl alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 50)];
    pagec.numberOfPages = 7;
    pagec.currentImage = [UIImage imageNamed:@"66"];
    pagec.defaultImage =[ UIImage imageNamed:@"55"];
    pagec.currentImageSize = CGSizeMake(10, 10);
    pagec.defaultImageSize = CGSizeMake(10, 10);
    [pagec addTarget:self action:@selector(caontain:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pagec];
    
    
    pa = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 300, self.view.width, 50)];
    pa.backgroundColor = [UIColor redColor];
    pa.numberOfPages = 4;
    [self.view addSubview:pa];
    
    
    UIButton * but =[[ UIButton alloc] initWithFrame:CGRectMake(0, pagec.bottom+50, 200, 60)];
    but.backgroundColor = [UIColor blueColor];
    [but addTarget:self action:@selector(clclc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    
    
}

- (void)clclc:(UIButton *)but
{
//    _page++;
//    pagec.currentPage = _page;
    
    
    [YLTools showLoading:@"++++"];
    

}

- (void)caontain:(YLPageControl *)page
{
    
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
