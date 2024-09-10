//
//  UIImage+XZKit.h
//  XZExtensions
//
//  Created by 徐臻 on 2024/6/12.
//

#import <UIKit/UIKit.h>
#import <XZDefines/XZDefer.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XZKit)
+ (nullable UIImage *)xz_imageWithColor:(UIColor *)color size:(CGSize)size NS_SWIFT_NAME(init(_:size:));
+ (nullable UIImage *)xz_imageWithColor:(UIColor *)color NS_SWIFT_NAME(init(_:));
@end

#pragma mark - 图片颜色混合

@interface UIImage (XZKitBlending)

// 命名：blend 需要宾语，因此用 blending 而不是 bended ：
// image blend (with) alpha => new image

/// 混合。改变图片透明度。
/// @param alpha 透明度
/// @return UIImage
- (nullable UIImage *)xz_imageByBlendingAlpha:(CGFloat)alpha NS_SWIFT_NAME(blending(alpha:));

/// 混合，重新渲染图片颜色。
/// @param tintColor 图片渲染色。
/// @return 渲染后的图片。
- (nullable UIImage *)xz_imageByBlendingTintColor:(UIColor *)tintColor NS_SWIFT_NAME(blending(tintColor:));

@end

#pragma mark - 滤镜

/// 图片色阶输入。
typedef struct XZImageInputColorLevel {
    /// 阴影。范围 0 ~ 1.0 ，默认 0 。
    CGFloat shadows;
    /// 中间调。范围 0 ~ 9.99 ，默认 1.0 。
    CGFloat midtones;
    /// 高光。范围 0 ~ 1.0 ，默认 1.0 。
    CGFloat highlights;
} XZImageInputColorLevel NS_SWIFT_NAME(XZImageColorLevels.Input);

/// 图片色阶输入默认值。
UIKIT_EXTERN XZImageInputColorLevel const XZImageInputColorLevelIdentity NS_SWIFT_NAME(XZImageInputColorLevel.identity);

/// 构造图片色阶输入结构体。
FOUNDATION_STATIC_INLINE XZImageInputColorLevel XZImageInputColorLevelMake(CGFloat shadows, CGFloat midtones, CGFloat highlights) {
    return (XZImageInputColorLevel){shadows, midtones, highlights};
}

/// 图片色阶输出。
typedef struct XZImageOutputColorLevel {
    /// 阴影。范围 0 ~ 1.0 ，默认 0 。
    CGFloat shadows;
    /// 高光。范围 0 ~ 1.0 ，默认 1.0 。
    CGFloat highlights;
} XZImageOutputColorLevel NS_SWIFT_NAME(XZImageColorLevels.Output);

/// 图片色阶输出默认值。
UIKIT_EXTERN XZImageOutputColorLevel const XZImageOutputColorLevelIdentity NS_SWIFT_NAME(XZImageOutputColorLevel.identity);

/// 构造图片色阶输出结构体。
FOUNDATION_STATIC_INLINE XZImageOutputColorLevel XZImageOutputColorLevelMake(CGFloat shadows, CGFloat highlights) {
    return (XZImageOutputColorLevel){shadows, highlights};
}

/// 颜色通道。
typedef NS_OPTIONS(NSUInteger, XZImageColorChannels) {
    /// 红色通道。
    XZImageColorChannelRed   = 1 << 0,
    /// 绿色通道。
    XZImageColorChannelGreen = 1 << 1,
    /// 蓝色通道。
    XZImageColorChannelBlue  = 1 << 2,
    /// 透明通道。
    XZImageColorChannelAlpha = 1 << 3,
    /// RGB三通道。
    XZImageColorChannelRGB   = XZImageColorChannelRed | XZImageColorChannelGreen | XZImageColorChannelBlue,
    /// 所有通道。
    XZImageColorChannelRGBA  = XZImageColorChannelRGB | XZImageColorChannelAlpha,
};

/// 图片色阶。
typedef struct XZImageColorLevels {
    XZImageInputColorLevel input;
    XZImageOutputColorLevel output;
} XZImageColorLevels;

FOUNDATION_STATIC_INLINE XZImageColorLevels XZImageColorLevelsMake(CGFloat inShadows, CGFloat inMidtones, CGFloat inHighlights, CGFloat outShadows, CGFloat outHighlights) {
    return (XZImageColorLevels){XZImageInputColorLevelMake(inShadows, inMidtones, inHighlights), XZImageOutputColorLevelMake(outShadows, outHighlights)};
}

@interface UIImage (XZKitFiltering)

/// 滤镜。改变图片亮度。
/// @note 图片处理属于高耗性能的操作。
/// @param brightness 图片亮度，取值范围 [0, 1.0]，默认 0.5
/// @return UIImage
- (nullable UIImage *)xz_imageByFilteringBrightness:(CGFloat)brightness NS_SWIFT_NAME(filtering(brightness:));

/// 图片色阶调整。
/// @see [Adobe Photoshop User Guide - Image adjustments](https://helpx.adobe.com/photoshop/using/levels-adjustment.html)
/// @param levels 色阶
/// @param channels 颜色通道
- (nullable UIImage *)xz_imageByFilteringLevels:(XZImageColorLevels)levels channels:(XZImageColorChannels)channels NS_SWIFT_NAME(filtering(levels:channels:));

@end

NS_ASSUME_NONNULL_END
