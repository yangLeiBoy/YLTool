//
//  YLPageControl.m
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLPageControl.h"
#import "YLTools.h"

@implementation YLPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}


- (void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage)
        {
            dot.image = self.currentImage;
            dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height);
        }
        else
        {
            dot.image = self.defaultImage;
            dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, self.defaultImageSize.width, self.defaultImageSize.height);
        }
    }
}
- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}
@end


