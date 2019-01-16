//
//  YLPageControl.h
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *defaultImage;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize defaultImageSize;

@end

