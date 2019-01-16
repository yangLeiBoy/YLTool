//
//  YLPublicInfo.m
//  YLDemo
//
//  Created by yangLei on 2019/1/14.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLPublicInfo.h"

@implementation YLPublicInfo

+ (YLPublicInfo *)shareYLPublicInfo
{
    static YLPublicInfo * info = nil;
    static dispatch_once_t onetoken;
    dispatch_once(&onetoken, ^{
        
        info = [[YLPublicInfo alloc] init];
    });
    return info;
}

@end
