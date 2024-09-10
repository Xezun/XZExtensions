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

/// 当前控制器，是否已开启状态栏样式配置能力。
/// @note 当属性`xz_preferredStatusBarStyle`、`xz_prefersStatusBarHidden`的`setter`方法被调用时，状态栏配置能力自动开启。
@property (nonatomic, readonly) BOOL xz_prefersStatusBarAppearance;

/// 当前控制器的状态栏样式。
/// @discussion
/// 设置此属性，XZKit 会重写控制器的 `preferredStatusBarStyle` 属性。
@property (nonatomic, setter=xz_setPreferredStatusBarStyle:) UIStatusBarStyle xz_preferredStatusBarStyle;

/// 设置当前控制器的状态栏样式。
/// @param preferredStatusBarStyle 待设置的样式
/// @param animated 是否展示动画
- (void)xz_setPreferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle animated:(BOOL)animated;

/// 当前状态栏是否隐藏。
/// @discussion 
/// UIKit 在处理状态栏是否隐藏时，并不是直接获取属性 `prefersStatusBarHidden` 的值，
/// 而是先调用`+doesOverrideViewControllerMethod:`方法，获取控制器自身是否重写了 `prefersStatusBarHidden` 属性。
/// 如果没重写，则不会读取 `prefersStatusBarHidden` 属性，在父类上进行方法交换，并不能生效。
///
/// 因此设置此属性时，XZKit 会重写控制器的 `prefersStatusBarHidden` 属性。
@property (nonatomic, setter=xz_setPrefersStatusBarHidden:) BOOL xz_prefersStatusBarHidden;

/// 设置状态栏隐藏或显示。
/// @param prefersStatusBarHidden 状态栏是否隐藏
/// @param animated 是否动画转场
- (void)xz_setPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
