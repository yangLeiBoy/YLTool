//
//  YLTools.m
//  YLCustomControls
//
//  Created by yangLei on 2019/1/9.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLTools.h"



@implementation YLTools

NSMutableDictionary * _MBProgressHUDMuDic;


+ (void)requestWithMethod:(NSString *)methodStr url:(NSString *)urlStr param:(NSDictionary *)paramDic haveLoading:(BOOL)isHaveLoading additionalDic:(NSDictionary *)additionalDic successfulBlock:(void (^) (id toolSucc))successful failBlock:(void (^) (id toolFail))fail
{
    if(isHaveLoading)
        [self showLoading:urlStr];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    [sessionManager.requestSerializer setValue:[JKTAllTools getuser_id] forHTTPHeaderField:@"user_id"];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sessionManager.requestSerializer.timeoutInterval = 5.0;
    [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    urlStr = [NSString stringWithFormat:@"%@%@",K_hostAddress,urlStr];

    
    [sessionManager POST:urlStr parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self removeLoading:urlStr];
        
        
        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([resultDictionary isKindOfClass:[NSDictionary class]])
        {
            id data = resultDictionary[@"data"];
            if(![data isKindOfClass:[NSNull class]])
                successful(resultDictionary);
            
        }
        else
        {
            [self showMBProgressHUD:@"服务器内部错误."];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self removeLoading:urlStr];
        
        fail(error);
        [self showMBProgressHUD:@"请求失败"];
        
    }];
}

+ (void)uploadImageOrVideoWithUrl:(NSString *)urlStr paraDic:(NSDictionary *)paraDic imageOrVideoArr:(NSArray *)imageOrVideoArr addIndefArr:(NSArray *)addIndefArr type:(NSInteger)type additionalDic:(NSDictionary *)additionalDic successfulBlock:(void (^) (id toolSucc))successful failBlock:(void (^) (id toolFail))fail
{
    [self showLoading:urlStr];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    [sessionManager.requestSerializer setValue:[self getuser_id] forHTTPHeaderField:@"user_id"];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    urlStr = [NSString stringWithFormat:@"%@%@",K_hostAddress,urlStr];
    
    [sessionManager POST:urlStr parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString * addIndef = @"";
        for(int i = 0;i < imageOrVideoArr.count;i++)
        {
            if(addIndefArr.count>0)
                addIndef = [NSString stringWithFormat:@"_%@",addIndefArr[i]];
            
            if(type==0)//图片
            {
                NSData * imageData = UIImagePNGRepresentation(imageOrVideoArr[i]);
                NSString * namePath = [NSString stringWithFormat:@"%@%@",[self getTimeStamp13Position:YES],addIndef];
                NSString *imagePath = [NSString stringWithFormat:@"%@.png",namePath];
                NSString *imageName = namePath;
                
                [formData appendPartWithFileData:imageData
                                            name:imageName
                                        fileName:imagePath
                                        mimeType:@"image/png"];
            }
            else if (type==1)//视频
            {
                NSData * videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageOrVideoArr[i]]];
                NSString * namePath = [NSString stringWithFormat:@"%@%@",[self getTimeStamp13Position:YES],addIndef];
                NSString *imagePath = [NSString stringWithFormat:@"%@.mp4",namePath];
                NSString *imageName = namePath;
                [formData appendPartWithFileData:videoData name:imageName fileName:imagePath mimeType:@"video/quicktime"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self removeLoading:urlStr];
        
        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([resultDictionary isKindOfClass:[NSDictionary class]])
        {
            successful(resultDictionary);
        }
        else
        {
            [self showMBProgressHUD:@"服务器内部错误."];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self removeLoading:urlStr];
        fail(error);
        
    }];
}


//  MBProgressHUD  提示框
+ (void)showMBProgressHUD:(NSString *)hudTitleStr
{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = hudTitleStr;
    hud.detailsLabel.font = [UIFont systemFontOfSize:19*k_width_scale];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    [hud hideAnimated:YES afterDelay:2];
    hud.removeFromSuperViewOnHide = YES;
    
}

//显示加载中
+ (void)showLoading:(NSString *)tag
{
    if(!_MBProgressHUDMuDic)
        _MBProgressHUDMuDic = [NSMutableDictionary dictionaryWithCapacity:1];
    
    
    

    
    if(![_MBProgressHUDMuDic.allKeys containsObject:tag] && tag.length > 0)
    {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[self getCurrVC].view animated:YES];
        hud.backgroundColor = [UIColor clearColor];
        hud.bezelView.color = [UIColor darkTextColor];
        hud.dimBackground = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.labelText = @"加载中";
        
        [_MBProgressHUDMuDic setObject:hud forKey:tag];
    }
    
    
}

//移除加载中
+ (void)removeLoading:(NSString *)tag
{
    if([_MBProgressHUDMuDic.allKeys containsObject:tag])
    {
        [(MBProgressHUD *)_MBProgressHUDMuDic[tag] hideAnimated:YES];
        [_MBProgressHUDMuDic removeObjectForKey:tag];
    }
}

+ (NSString *)getTimeStamp13Position:(BOOL)is13Position
{
    CGFloat temp = 1.0;
    if(is13Position)
        temp = 1000.0;
    
    //获取当前时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*temp;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeSp = [NSString stringWithFormat:@"%f",time];
    return timeSp;
        
}

+ (void)saveDataToLocalWithValue:(id)value key:(NSString *)key
{
    if(!value)
        return;
    if(key.length==0)
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getDataToLocalWithKey:(NSString *)key
{
    if(key.length==0)
        key = @"";
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeDataToLocalWithKey:(NSString *)key
{
    if(key.length>0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSDictionary *)jsonToDic:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**字典转json格式字符串：*/
+ (NSString*)dicToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
/**数组转json*/
+(NSString *)arrToJson:(NSArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonResult;
}

+ (NSString *)arrToNSString:(NSArray *)arr separat:(NSString *)separat
{
    NSString * temp = @"";
    for(int i = 0;i < arr.count;i++)
    {
        temp = [NSString stringWithFormat:@"%@%@%@",temp,arr[i],separat];
    }
    if(temp.length>1)
        temp = [temp substringWithRange:NSMakeRange(0, temp.length-1)];
    return temp;
}

+ (NSString *)chineseToPinyin:(NSString *)string
{
    /*复制出一个可变的对象*/
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    
    /*多音字处理*/
    if([string rangeOfString:@"银行"].length>0)
    {
        preString = [NSMutableString stringWithString:[preString stringByReplacingOccurrencesOfString:@"yin xing" withString:@"yin hang"]];
    }
    
    return [preString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (UIViewController *)getCurrVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;  
}

/**app图标*/
+ (UIImage *)getAppIcon
{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage* image = [UIImage imageNamed:icon];
    return image;
}
/**app名称*/
+ (NSString *)getAppName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
/**app版本号*/
+ (NSString *)getAppVersionNumber
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (BOOL)isAllowAccessCamera
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        return NO;
    }
    return YES;
}


+ (BOOL)isAllowAccessPhotoAlbum
{    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}


+ (BOOL)isLiuHaiPing
{
    if (@available(iOS 11.0, *)) {
        if([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0)
            return YES;
    } else {
        // Fallback on earlier versions
    }
    return NO;
}

+ (CGFloat)getNavigationHeight
{
    if([self isLiuHaiPing])
        return 88;
    return 64;
}

+ (CGFloat)getTabBarHeight
{
    if([self isLiuHaiPing])
        return 83;
    return 49;
}

+ (CGFloat)getNavigationNewAddHeight
{
    if([self isLiuHaiPing])
        return 24;
    return 0;
}

+ (CGFloat)getTabBarNewAddHeight
{
    if([self isLiuHaiPing])
        return 34;
    return 0;
}

+ (CGFloat)getStateBarHeight
{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    return statusRect.size.height;
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str
{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


+ (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath])
        return 0 ;
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    CGFloat folderSize = 0.0 ;
    while((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize;
}




+ (CGFloat)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1000.0/1000.0;
    }
    return 0 ;
}

+ (NSString *)getCurrLanguage
{
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    return languageName;
}

+ (UIImage *)getCustomSizeImageWithW:(CGFloat)width H:(CGFloat)height BGC:(UIColor *)bgc contentScale:(CGFloat)contentScale imageScale:(CGFloat)imageScale imageName:(NSString *)imageName;
{
    if(width>0)
    {
        
    }
    else
    {
        return [UIImage new];
    }
    UIView * bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    bgv.backgroundColor = bgc;
    
    CGFloat contentW = bgv.frame.size.width*contentScale;
    CGFloat contentH = contentW*imageScale;
    UIImageView * contentIV = [[UIImageView alloc] initWithFrame:CGRectMake((bgv.frame.size.width-contentW)/2, (bgv.frame.size.height-contentH)/2, contentW, contentH)];
    contentIV.image = [UIImage imageNamed:imageName];
    [bgv addSubview:contentIV];
    
    UIImage * customIM = [bgv screenshot];
    return customIM;
}

+ (UIColor *)hexToColor:(NSString *)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (NSString *)dateShowDealWith:(NSString *)dateString withFormate:(NSString *)formate
{
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = NSLocalizedString(@"刚刚", nil);
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d%@",mins,NSLocalizedString(@"分钟前", nil)];
            
        }else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"今天", nil),[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"昨天", nil),[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
                NSArray * temparr = [dateStr componentsSeparatedByString:@"/"];
                NSString * yue = temparr[1];
                NSString * ri = temparr[2];
                dateStr = [NSString stringWithFormat:@"%@%@%@%@",yue,NSLocalizedString(@"月", nil),ri,NSLocalizedString(@"日", nil)];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

+ (void)addKeyboardManger
{
    IQKeyboardManager * keyBoardManager = [IQKeyboardManager sharedManager];
    keyBoardManager.enable = YES;
    keyBoardManager.shouldResignOnTouchOutside = YES;
}

+ (void)addAvoidCrash
{
    //启动防止崩溃功能(注意区分becomeEffective和makeAllEffective的区别)
    //具体区别请看 AvoidCrash.h中的描述
    //建议在didFinishLaunchingWithOptions最初始位置调用 上面的方法
    
    [AvoidCrash makeAllEffective];
    
    //若出现unrecognized selector sent to instance导致的崩溃并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    NSArray *noneSelClassStrings = @[@"NSString"];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

+ (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}












@end
