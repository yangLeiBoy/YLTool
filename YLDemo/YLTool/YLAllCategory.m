//
//  YLAllCategory.m
//  YLDemo
//
//  Created by yangLei on 2019/1/12.
//  Copyright © 2019 yangLei. All rights reserved.
//

#import "YLAllCategory.h"

@implementation YLAllCategory

@end







static void *label_key = &label_key;
static void *textF_key = &textF_key;
static void *but_key = &but_key;
static void *textV_key = &textV_key;
static void *horizontal_key = &horizontal_key;
static void *vertical_key = &vertical_key;


/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UILabel (YLCustomLabel)

- (void)setFitFontSize:(CGFloat)fitFontSize
{
    self.font = [UIFont fontWithName:self.font.fontName size:k_width_scale*fitFontSize];
    objc_setAssociatedObject(self, &label_key, @(fitFontSize), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)fitFontSize
{
    return [objc_getAssociatedObject(self, &label_key) floatValue];
}



/**改变行间距*/
- (void)changeLineSpace:(CGFloat)space
{
    
    NSString *labelText = self.text;
    if(labelText.length==0)
        return;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

/**改变字间距*/
- (void)changeWordSpace:(CGFloat)space
{
    
    NSString *labelText = self.text;
    if(labelText.length==0)
        return;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

/**改变行间距和字间距*/
- (void)changeSpaceLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace
{
    
    NSString *labelText = self.text;
    if(labelText.length==0)
        return;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}



- (void)changePartColorRangeArray:(NSArray *)array
{
    NSMutableAttributedString * changeColorStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    for(int i = 0;i < array.count;i++)
    {
        NSArray * tempArr = array[i];
        
        if([tempArr[1] integerValue]+[tempArr[2] integerValue] <= self.text.length)
            [changeColorStr addAttribute:NSForegroundColorAttributeName value:tempArr[0] range:NSMakeRange([tempArr[1] integerValue], [tempArr[2] integerValue])];
    }
    self.attributedText = changeColorStr;
}

@end




/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UITextField (YLCustomTF)

- (void)setFitFontSize:(CGFloat)fitFontSize
{
    self.font = [UIFont fontWithName:self.font.fontName size:k_width_scale*fitFontSize];
    objc_setAssociatedObject(self, &textF_key, @(fitFontSize), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)fitFontSize
{
    return [objc_getAssociatedObject(self, &textF_key) floatValue];
}


- (UILabel *)getPlaceholderLabel
{
    UILabel * placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
    return placeholderLabel;
}


- (BOOL)textFieldTextIsNil
{
    if(self.text.length==0)
    {
        [YLTools showMBProgressHUD:self.placeholder];
        return YES;
    }
    return NO;
}

@end





/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UITextView (YLCustomTextV)

- (void)setFitFontSize:(CGFloat)fitFontSize
{
    self.font = [UIFont fontWithName:self.font.fontName size:k_width_scale*fitFontSize];
    objc_setAssociatedObject(self, &textV_key, @(fitFontSize), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)fitFontSize
{
    return [objc_getAssociatedObject(self, &textV_key) floatValue];
}

@end





/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIButton (YLCustomBut)

- (void)setFitFontSize:(CGFloat)fitFontSize
{
    self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:k_width_scale*fitFontSize];
    objc_setAssociatedObject(self, &but_key, @(fitFontSize), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)fitFontSize
{
    return [objc_getAssociatedObject(self, &but_key) floatValue];
}


- (void)changeButTitleInset:(ButImageInsetsStyle)style space:(CGFloat)space
{
    CGFloat imageWidth = self.imageView.width;
    CGFloat imageHeight = self.imageView.height;
    
    CGFloat labelWidth = self.titleLabel.width;
    CGFloat labelHeight = self.titleLabel.height;
    
    UIEdgeInsets imageInsets;
    UIEdgeInsets titleInsets;
    
    
    switch (style) {
        case top:
        {
            titleInsets = UIEdgeInsetsMake(-(imageHeight + labelHeight + space),-imageWidth, 0, 0);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, -labelWidth);
        }
            break;
        case bottom:
        {
            titleInsets = UIEdgeInsetsMake((imageHeight + labelHeight + space),-imageWidth, 0, 0);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, -labelWidth);
        }
            break;
        case left:
        {
            titleInsets = UIEdgeInsetsMake(0, -(imageWidth * 2), 0, 0);
            imageInsets = UIEdgeInsetsMake(0, 0, 0,-(labelWidth * 2 + space));
        }
            break;
        case right:
        {
            titleInsets = UIEdgeInsetsMake(0, 0, 0, -space);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
            break;
        default:
            break;
    }
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = imageInsets;
}

@end




/////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSLayoutConstraint (YLCustomCons)

- (void)setHorizontalConstant:(CGFloat)horizontalConstant {
    
    self.constant = horizontalConstant*k_width_scale;
    objc_setAssociatedObject(self, &horizontal_key, @(horizontalConstant), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)horizontalConstant {
    return [objc_getAssociatedObject(self, &horizontal_key) floatValue];
}

- (void)setVerticalConstant:(CGFloat)verticalConstant {
    
    self.constant = verticalConstant*k_width_scale;
    objc_setAssociatedObject(self, &vertical_key, @(verticalConstant), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)verticalConstant {
    return [objc_getAssociatedObject(self, &vertical_key) floatValue];
}

@end







/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIView (YLCustomView)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (void)alertToCallPhone:(NSString *)phoneNum
{
    phoneNum = [phoneNum getNumberFromStr];
    
    NSMutableString * phoneStr =[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneStr]]];
    [self addSubview:callWebview];
}

- (SDCycleScrollView *)addSDCycleScrollView:(CGRect)SDframe phImage:(UIImage *)phImage additionalDic:(NSDictionary *)additional
{
    SDCycleScrollView * sd = [SDCycleScrollView cycleScrollViewWithFrame:SDframe delegate:nil placeholderImage:phImage];
    sd.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    sd.pageDotColor = [UIColor grayColor];
    sd.currentPageDotColor = [UIColor whiteColor];
    sd.autoScrollTimeInterval = 2;
    sd.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:sd];
    
    return sd;
}


- (UIImage *)screenshot
{
    CGRect rect = self.frame;  //截取图片大小
    
    //开始取图，参数：截图图片大小
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    //截图层放入上下文中
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束截图
    UIGraphicsEndImageContext();
    return image;
}

@end






@implementation UIImage (YLCustomImage)

//按比例改变图片大小
-(UIImage*)changeImageSizeWithOriginalImage:(UIImage*)image percent:(float)percent
{
    // change the image size
    UIImage *changedImage=nil;
    float iwidth=image.size.width*percent;
    float iheight=image.size.height*percent;
    if (image.size.width != iwidth && image.size.height != iheight)
    {
        CGSize itemSize = CGSizeMake(iwidth, iheight);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        changedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        changedImage = image;
    }
    
    return changedImage;
}


//圆形
-(UIImage*)circleImage:(UIImage*)image
{
    CGFloat inset = 0.1f;
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
//方向旋转  水平:UIImageOrientationUpMirrored
-(UIImage *)rotateImage:(UIImage *)aImage with:(UIImageOrientation)theorient
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = theorient;//aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
//方向
-(UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


//  压缩为目标宽度         等比例压缩     改变图片宽和高
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = defineWidth;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end




/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIColor (YLCustomColor)

/**通过颜色得到图片*/
- (UIImage *)colorToImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end







/////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (YLCustomNSString)

- (NSString *)getNumberFromStr
{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[self componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

@end












/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIScrollView (YLCustomSV)

- (void)addMJRefreshHeader
{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJRefreshReloadData:)];
    self.mj_header = header;
}

- (void)addMJRefreshFooter
{
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJRefreshMoreData:)];
    self.mj_footer = footer;
}

- (void)addMJRefreshEnd
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)addMJRefreshNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)addMJRefreshResetNoMoreData
{
    [self.mj_footer resetNoMoreData];
}

/**下拉刷新*/
- (void)MJRefreshReloadData:(UIScrollView *)sv
{
}

/**上拉加载更多*/
- (void)MJRefreshMoreData:(UIScrollView *)sv
{
}



@end








/////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIViewController (YLCustomVC)

- (void)addAlertVC:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message otherButArr:(NSArray *)otherButArr haveCancelBut:(BOOL)haveCancelBut otherButBlock:(void (^)(NSInteger index))otherButBlock
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for(int i = 0;i < otherButArr.count;i++)
    {
        UIAlertAction * ac = [UIAlertAction actionWithTitle:otherButArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            otherButBlock([otherButArr indexOfObject:action.title]);
        }];
        [alertVC addAction:ac];
    }
    
    if(haveCancelBut)
    {
        UIAlertAction * cancelAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        [alertVC addAction:cancelAC];
    }
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (void)addNAVCRightButTitleArr:(NSArray *)titleArr imageArr:(NSArray *)imageArr
{
    NSMutableArray * muarr = [NSMutableArray arrayWithCapacity:1];
    for(int i = 0;i < titleArr.count;i++)
    {
        UIButton * rightB = [UIButton buttonWithType:UIButtonTypeCustom];
        rightB.frame = CGRectMake(0, 0, 40, 40);
        [rightB setTitle:titleArr[i] forState:UIControlStateNormal];
        [rightB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightB.titleLabel.font = [UIFont systemFontOfSize:10];
        if(imageArr.count > 0)
        {
            if([imageArr[i] length] > 0)
            {
                [rightB setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
                [rightB changeButTitleInset:bottom space:5];
            }
        }
        rightB.tag = 301+i;
        [rightB addTarget:self action:@selector(clickNAVCRightBut:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightB];
        [muarr addObject:item];
    }
    self.navigationItem.rightBarButtonItems = muarr;
}

/**点击导航栏右边按钮 301开始*/
- (void)clickNAVCRightBut:(UIButton *)but
{
}



- (void)addDatePicker:(PGDatePickerMode)dateMode title:(NSString *)title minData:(NSDate *)minData maxData:(NSDate *)maxData selectDateEndBlock:(void (^)(NSDateComponents *dateComponents))selectDateEndBlock
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.datePickerMode = dateMode;
    [self presentViewController:datePickManager animated:false completion:nil];
    
    datePickManager.titleLabel.text = title.length == 0? @"请选择日期":title;
    //设置半透明的背景颜色
    datePickManager.isShadeBackground = true;
    //设置头部的背景颜色
    datePickManager.headerViewBackgroundColor = [UIColor orangeColor];
    //设置线条的颜色
    datePicker.lineBackgroundColor = [UIColor redColor];
    //设置选中行的字体颜色
    datePicker.textColorOfSelectedRow = [UIColor redColor];
    //设置未选中行的字体颜色
    datePicker.textColorOfOtherRow = [UIColor blackColor];
    //设置取消按钮的字体颜色
    datePickManager.cancelButtonTextColor = [UIColor blackColor];
    //设置取消按钮的字
    datePickManager.cancelButtonText = @"取消";
    //设置取消按钮的字体大小
    datePickManager.cancelButtonFont = [UIFont boldSystemFontOfSize:17];
    //设置确定按钮的字体颜色
    datePickManager.confirmButtonTextColor = [UIColor redColor];
    //设置确定按钮的字
    datePickManager.confirmButtonText = @"确定";
    //设置确定按钮的字体大小
    datePickManager.confirmButtonFont = datePickManager.cancelButtonFont;
    //如果不设置minimumDate和maximumDate默认是无穷小和无穷大
    if(minData)
        datePicker.minimumDate = minData;
    if(maxData)
        datePicker.maximumDate = maxData;
    
    datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
        
        selectDateEndBlock(dateComponents);
        
    };

}

@end
