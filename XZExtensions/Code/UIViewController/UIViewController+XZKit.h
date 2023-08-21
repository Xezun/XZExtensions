//
//  UIViewController+XZKit.h
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import <UIKit/UIKit.h>
#import <XZDefines/XZRuntime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XZKit)

/// 当前控制器的状态栏样式。
@property (nonatomic, setter=xz_setStatusBarStyle:) UIStatusBarStyle xz_statusBarStyle;

/// 设置当前控制器的状态栏样式。
/// @param statusBarStyle 待设置的样式
/// @param animated 是否展示动画
- (void)xz_setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated;

/// 当前状态栏是否隐藏。
/// @warning 需要控制器重写 -prefersStatusBarHidden 方法，并返回此属性值。
/// @code
/// - (BOOL)prefersStatusBarHidden {
///     return [self xz_statusBarHidden];
/// }
/// @endcode
@property (nonatomic, setter=xz_setStatusBarHidden:) BOOL xz_statusBarHidden;

/// 设置状态栏隐藏或显示。
/// @param statusBarHidden 状态栏是否隐藏
/// @param animated 是否动画转场
- (void)xz_setStatusBarHidden:(BOOL)statusBarHidden animated:(BOOL)animated;

@end

@interface UINavigationController (XZKit)
@end

@interface UITabBarController (XZKit)
@end

NS_ASSUME_NONNULL_END
