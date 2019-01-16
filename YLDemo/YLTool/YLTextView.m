//
//  YLTextView.m
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLTextView.h"
#import "YLTools.h"

@implementation YLTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self customInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self customInit];
}


- (void)customInit
{
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    
    self.delegate = self;
    
    //   实现占位符
    _placeholderL = [[UILabel alloc] initWithFrame:CGRectMake(5*k_width_scale, 0, self.frame.size.width-10*k_width_scale, 40*k_width_scale)];
    _placeholderL.text = @"请输入内容";
    _placeholderL.textColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1];
    _placeholderL.font = [UIFont systemFontOfSize:17*k_width_scale];
    [self addSubview:_placeholderL];
    
    
    [self performSelector:@selector(judgeIsNotHaveText) withObject:nil afterDelay:1.0];
}

- (void)judgeIsNotHaveText
{
    if(self.text.length>0)
        _placeholderL.hidden = YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.text.length==0)
    {//textview长度为0
        if ([text isEqualToString:@""])
        {//判断是否为删除键
            _placeholderL.hidden=NO;//隐藏文字
        }
        else
        {
            _placeholderL.hidden=YES;
        }
    }
    else
    {//textview长度不为0
        if (self.text.length==1)
        {//textview长度为1时候
            if ([text isEqualToString:@""])
            {//判断是否为删除键
                _placeholderL.hidden=NO;
            }
            else
            {//不是删除
                _placeholderL.hidden=YES;
            }
        }
        else
        {//长度不为1时候
            _placeholderL.hidden=YES;
        }
    }
    return YES;
}




@end
