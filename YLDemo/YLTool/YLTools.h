//
//  YLTools.h
//  YLCustomControls
//
//  Created by yangLei on 2019/1/9.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Photos/Photos.h>//是否有权限访问相册
#import <AVFoundation/AVCaptureDevice.h>//是否有权限访问相机
#import <AVFoundation/AVMediaFormat.h>//是否有权限访问相机

#import <CommonCrypto/CommonDigest.h>//MD5加密

#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"
#import "AvoidCrash.h"
#import "PGDatePickManager.h"
#import "SDCycleScrollView.h"
//#import "HXPhotoPicker.h"

#import "YLSystemHeader.h"
#import "YLNavigationController.h"
#import "YLPageControl.h"
#import "YLWebViewController.h"
#import "YLTextView.h"
#import "YLAllCategory.h"
#import "YLPublicInfo.h"



@interface YLTools : NSObject

+ (void)requestWithMethod:(NSString *)methodStr url:(NSString *)urlStr param:(NSDictionary *)paramDic haveLoading:(BOOL)isHaveLoading additionalDic:(NSDictionary *)additionalDic successfulBlock:(void (^) (id toolSucc))successful failBlock:(void (^) (id toolFail))fail;

/**上传图片或视频。  type 0图片 1视频*/
+ (void)uploadImageOrVideoWithUrl:(NSString *)urlStr paraDic:(NSDictionary *)paraDic imageOrVideoArr:(NSArray *)imageOrVideoArr addIndefArr:(NSArray *)addIndefArr type:(NSInteger)type additionalDic:(NSDictionary *)additionalDic successfulBlock:(void (^) (id toolSucc))successful failBlock:(void (^) (id toolFail))fail;

//  MBProgressHUD  提示框
+ (void)showMBProgressHUD:(NSString *)hudTitleStr;

//显示加载中
+ (void)showLoading:(NSString *)tag;
//移除加载中
+ (void)removeLoading:(NSString *)tag;

/**时间戳*/
+ (NSString *)getTimeStamp13Position:(BOOL)is13Position;


//保存  获取  删除  数据从本地
+ (void)saveDataToLocalWithValue:(id)value key:(NSString *)key;
+ (id)getDataToLocalWithKey:(NSString *)key;
+ (void)removeDataToLocalWithKey:(NSString *)key;

/**json转字典*/
+ (NSDictionary *)jsonToDic:(NSString *)jsonString;
/**字典转json格式字符串：*/
+ (NSString*)dicToJson:(NSDictionary *)dic;
/**数组转json*/
+(NSString *)arrToJson:(NSArray *)array;
/**数组转字符串 用separat分隔开*/
+ (NSString *)arrToNSString:(NSArray *)arr separat:(NSString *)separat;

/**汉字转拼音 多音字没处理*/
+ (NSString *)chineseToPinyin:(NSString *)string;

/**获取当前屏幕显示的viewcontroller  */
+ (UIViewController *)getCurrVC;

/**app图标*/
+ (UIImage *)getAppIcon;
/**app名称*/
+ (NSString *)getAppName;
/**app版本号*/
+ (NSString *)getAppVersionNumber;

//权限判断 info.plist里面添加 App Transport Security Settings ,字典里添加 （ Privacy - Camera Usage Description  ： 我们会在扫码，上传照片等服务中使用您的相机权限）（Privacy - Photo Library Usage Description ： 我们会在上传照片等服务中使用您的相册权限）
/** 是否允许访问相机*/
+ (BOOL)isAllowAccessCamera;
/**是否允许访问相册*/
+ (BOOL)isAllowAccessPhotoAlbum;

+ (BOOL)isLiuHaiPing;
+ (CGFloat)getNavigationHeight;
+ (CGFloat)getTabBarHeight;
+ (CGFloat)getNavigationNewAddHeight;
+ (CGFloat)getTabBarNewAddHeight;
+ (CGFloat)getStateBarHeight;


/**32位 小写*/
+(NSString *)MD5ForLower32Bate:(NSString *)str;
/**32位 大写*/
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
/**16位 大写*/
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
/**16位 小写*/
+(NSString *)MD5ForLower16Bate:(NSString *)str;



/**  文件夹  大小（单位 MB）*/
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath;
/**  文件  大小 （单位 MB）*/
+ (CGFloat)fileSizeAtPath:(NSString *)filePath;


//获取当前语言环境
+ (NSString *)getCurrLanguage;

/**十六进制颜色值转换成UIColor对象*/
+ (UIColor *)hexToColor:(NSString *)hex;

/**
 获取自定义大小的uiimage
 width 最终image宽
 height 最终image高
 bgc 最终image背景色
 contentScale 内容图片占最终图片比例
 imageScale 内容图片 高／宽
 imageName 内容图片名字
 */
+ (UIImage *)getCustomSizeImageWithW:(CGFloat)width H:(CGFloat)height BGC:(UIColor *)bgc contentScale:(CGFloat)contentScale imageScale:(CGFloat)imageScale imageName:(NSString *)imageName;

/**
 和当前时间比较
 1）1分钟以内 显示        :    刚刚
 2）1小时以内 显示        :    X分钟前
 3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 4) 今年显示              :   09月12日
 5) 大于本年      显示    :    2013/09/09
 */
+ (NSString *)dateShowDealWith:(NSString *)dateString withFormate:(NSString *)formate;







/**键盘管理*/
+ (void)addKeyboardManger;

/**防部分闪退*/
+ (void)addAvoidCrash;






@end

