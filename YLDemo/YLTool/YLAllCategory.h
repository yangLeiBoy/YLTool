//
//  YLAllCategory.h
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "YLTools.h"

@interface YLAllCategory : NSObject

@end






/////////////////////////////////////////////////////////////////////////////////////////////
@interface UILabel (YLCustomLabel)

@property(nonatomic,assign)IBInspectable CGFloat fitFontSize;

/**改变行间距*/
- (void)changeLineSpace:(CGFloat)space;

/**改变字间距*/
- (void)changeWordSpace:(CGFloat)space;

/**改变行间距和字间距*/
- (void)changeSpaceLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;

/**改变label上某部分字的颜色。  （颜色，从第几个字开始，几个字）。@[@[],@[]];*/
- (void)changePartColorRangeArray:(NSArray *)array;



@end





/////////////////////////////////////////////////////////////////////////////////////////////
@interface UITextField (YLCustomTF)

@property(nonatomic,assign)IBInspectable CGFloat fitFontSize;

/**得到占位的label*/
- (UILabel *)getPlaceholderLabel;

/**tf是空 提示占位符 返回yes。否则返回 no*/
- (BOOL)textFieldTextIsNil;

@end





/////////////////////////////////////////////////////////////////////////////////////////////
@interface UITextView (YLCustomTextV)

@property(nonatomic,assign)IBInspectable CGFloat fitFontSize;

@end






/////////////////////////////////////////////////////////////////////////////////////////////
typedef enum : NSUInteger {
    top,
    left,
    bottom,
    right,
} ButImageInsetsStyle;

@interface UIButton (YLCustomBut)

@property(nonatomic,assign)IBInspectable CGFloat fitFontSize;

/**改变按钮图片，文字位置*/
- (void)changeButTitleInset:(ButImageInsetsStyle)style space:(CGFloat)space;

@end





/////////////////////////////////////////////////////////////////////////////////////////////
@interface NSLayoutConstraint (YLCustomCons)

/** 水平方向约束*/
@property (nonatomic, assign)IBInspectable CGFloat horizontalConstant;
/** 竖直方向约束 */
@property (nonatomic, assign)IBInspectable CGFloat verticalConstant;

@end







/////////////////////////////////////////////////////////////////////////////////////////////
@interface UIView (YLCustomView)

@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat bottom;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;


/**打电话*/
- (void)alertToCallPhone:(NSString *)phoneNum;

/**添加轮播图*/
- (SDCycleScrollView *)addSDCycleScrollView:(CGRect)SDframe phImage:(UIImage *)phImage additionalDic:(NSDictionary *)additional;

/**截图*/
- (UIImage *)screenshot;

@end





/////////////////////////////////////////////////////////////////////////////////////////////
@interface UIImage (YLCustomImage)

/**按比例改变图片大小*/
-(UIImage*)changeImageSizeWithOriginalImage:(UIImage*)image percent:(float)percent;

/**圆形*/
-(UIImage*)circleImage:(UIImage*)image;

/**截取部分图像*/
-(UIImage*)getSubImage:(CGRect)rect;

/**等比例缩放*/
-(UIImage*)scaleToSize:(CGSize)size;

/**旋转*/
-(UIImage *)rotateImage:(UIImage *)aImage with:(UIImageOrientation)theorient;

/**图片旋转90度的解决办法*/
-(UIImage *)fixOrientation:(UIImage *)aImage;

/**压缩为目标宽度         等比例压缩     改变图片宽和高*/
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end








/////////////////////////////////////////////////////////////////////////////////////////////
@interface UIColor (YLCustomColor)

/**通过颜色得到图片*/
- (UIImage *)colorToImage;



@end






/////////////////////////////////////////////////////////////////////////////////////////////
@interface NSString (YLCustomNSString)

/**获取字符串中的数字*/
- (NSString *)getNumberFromStr;


@end









/////////////////////////////////////////////////////////////////////////////////////////////
@interface UIScrollView (YLCustomSV)

/**添加下拉刷新*/
- (void)addMJRefreshHeader;

/**添加上拉加载*/
- (void)addMJRefreshFooter;

/**结束刷新*/
- (void)addMJRefreshEnd;

/**没有更多数据*/
- (void)addMJRefreshNoMoreData;

/**有更多数据*/
- (void)addMJRefreshResetNoMoreData;

/**下拉刷新*/
- (void)MJRefreshReloadData:(UIScrollView *)sv;
/**上拉加载更多*/
- (void)MJRefreshMoreData:(UIScrollView *)sv;


@end








/////////////////////////////////////////////////////////////////////////////////////////////
@interface UIViewController (YLCustomVC)

/**添加弹出框*/
- (void)addAlertVC:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message otherButArr:(NSArray *)otherButArr haveCancelBut:(BOOL)haveCancelBut otherButBlock:(void (^)(NSInteger index))otherButBlock;

/**添加导航栏右侧按钮*/
- (void)addNAVCRightButTitleArr:(NSArray *)titleArr imageArr:(NSArray *)imageArr;
/**点击导航栏右边按钮*/
- (void)clickNAVCRightBut:(UIButton *)but;

/**时间选择器 时间为空代表无穷大/小*/
- (void)addDatePicker:(PGDatePickerMode)dateMode title:(NSString *)title minData:(NSDate *)minData maxData:(NSDate *)maxData selectDateEndBlock:(void (^)(NSDateComponents *dateComponents))selectDateEndBlock;


@end

