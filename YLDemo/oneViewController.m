//
//  oneViewController.m
//  YLDemo
//
//  Created by yangLei on 2019/1/15.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "oneViewController.h"
#import "YLTools.h"
@interface oneViewController ()

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    [self addNAVCRightButTitleArr:@[@"枪枪",@"问问"] imageArr:@[@"22",@"33"]];
    
}

/**点击导航栏右边按钮 301开始*/
- (void)clickNAVCRightBut:(UIButton *)but
{
    if(but.tag == 301)
    {
        [self addAlertVC:UIAlertControllerStyleAlert title:@"title" message:@"message" otherButArr:@[@"1",@"2",@"3"] haveCancelBut:YES otherButBlock:^(NSInteger index) {
            
            
        }];
    }
    if(but.tag == 302)
    {
        [self addDatePicker:PGDatePickerModeDateHourMinuteSecond title:@"hahah" minData:nil maxData:nil selectDateEndBlock:^(NSDateComponents *dateComponents) {
            
            NSLog(@"%ld-%ld-%ld : %ld:%ld:%ld",dateComponents.year,dateComponents.month,dateComponents.day,dateComponents.hour,dateComponents.minute,dateComponents.second);
        }];
    }
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
