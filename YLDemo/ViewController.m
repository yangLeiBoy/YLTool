//
//  ViewController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "ViewController.h"
#import "YLTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel * l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 100)];
    l1.numberOfLines = 0;
    l1.text = @"012345678";
    l1.textColor = [UIColor darkTextColor];
    l1.font = [UIFont systemFontOfSize:20*k_width_scale];
    l1.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:l1];
//    [l1 changeSpaceLineSpace:30 WordSpace:30];
//    [l1 changePartColorRangeArray:@[@[[UIColor redColor],@"0",@"4"],@[[UIColor cyanColor],@"4",@"5"]]];
    
    UILabel * l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 100)];
    l2.text = @"今晚发生的彼此上档次今晚发生的彼此上档次今晚发生的彼此上档次";
    l2.numberOfLines = 0;
    l2.textColor = [UIColor blueColor];
    l2.font = [UIFont systemFontOfSize:20*k_width_scale];
    l2.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:l2];
    
    
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 50)];
    tf.textColor = [UIColor redColor];
    tf.font = [UIFont systemFontOfSize:20];
    tf.placeholder = @"dddd";
//    [self.view addSubview:tf];
    
    
    [tf getPlaceholderLabel].textColor = [UIColor blueColor];
    [tf getPlaceholderLabel].text = @"uuu";
    
    
    for(int i = 0;i < 4;i++)
    {
        UIButton * but =[ UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(200*i, 50, 150, 150);
        if(i>1)
            but.frame = CGRectMake(200*(i-2), 230, 150, 150);
        but.backgroundColor = [UIColor redColor];
        [but setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:20];
        but.titleLabel.backgroundColor = [UIColor cyanColor];
        
        [but setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [self.view addSubview:but];
        
        if(i==0)
            [but changeButTitleInset:left space:5];
        else if (i==1)
            [but changeButTitleInset:top space:5];
        else if (i==2)
            [but changeButTitleInset:bottom space:5];
        else if (i==3)
            [but changeButTitleInset:right space:5];
        but.tag = 401+i;
        [but addTarget:self action:@selector(clickxx:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    UIColor * c = [UIColor colorWithRed:75/255.0 green:217/255.0 blue:255/255.0 alpha:1   ];
    UIImageView * im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
    im.image = [c colorToImage];
//    [self.view addSubview:im];
    
}


- (void)clickxx:(UIButton *)but
{
    if(but.tag == 401)
    {
        [self.view alertToCallPhone:@"10地产08家啊点61爱丁堡sd1"];
    }
    else if (but.tag == 402)
    {
        SDCycleScrollView * sd = [self.view addSDCycleScrollView:CGRectMake(0, 400, self.view.width, 200) phImage:nil additionalDic:nil];
        sd.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548139652&di=7427aa67d14ccfb83ea3bdcb60769a1b&imgtype=jpg&er=1&src=http%3A%2F%2Fbpic.ooopic.com%2F16%2F06%2F99%2F16069994-76b68988de6cbc8444fbc5ed81e59ffc-1.jpg",@"http://pic15.photophoto.cn/20100612/0020033026742382_b.jpg"];
        
    }
    else if (but.tag==403)
    {
        UIButton * ee =[ UIButton buttonWithType:UIButtonTypeCustom];
        ee.frame = CGRectMake(0, 400, self.view.width, self.view.height-400);
        [ee setBackgroundImage:[[self.view viewWithTag:401] screenshot] forState:UIControlStateNormal];
//        [self.view addSubview:ee];
    }
}


@end
