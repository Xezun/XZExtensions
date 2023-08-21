//
//  UIViewController+XZKit.m
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import "UIViewController+XZKit.h"
#import <objc/runtime.h>
#import "UIApplication+XZKit.h"

#define XZ_STATUS_BAR_HIDDEN_MANAGABLE 0

static const void * const _statusBarStyle = &_statusBarStyle;
static const void * const _statusBarHidden = &_statusBarHidden;

#if XZ_STATUS_BAR_HIDDEN_MANAGABLE
@protocol XZStatusBarHiddenViewControllerManagable <NSObject>
+ (BOOL)doesOverrideViewControllerMethod:(SEL)sel;
@end
#endif

@implementation UIViewController (XZKit)

+ (void)load {
    SEL const sel1 = @selector(preferredStatusBarStyle);
    SEL const sel2 = @selector(xz_statusBarStyle);
    xz_objc_class_addMethod(UIViewController.class, sel1, sel2, sel2, sel2);

#if XZ_STATUS_BAR_HIDDEN_MANAGABLE
    SEL const sel3 = @selector(prefersStatusBarHidden);
    SEL const sel4 = @selector(xz_statusBarHidden);
    xz_objc_class_addMethod(UIViewController.class, sel3, sel4, sel4, sel4);
    
    // 重写控制 doesOverrideViewControllerMethod: 否则交换后 -prefersStatusBarHidden 不会被访问。
    // 内部机制应该是：
    // 1、先访问 -doesOverrideViewControllerMethod: 方法判断控制器是否重写了 -prefersStatusBarHidden 方法；
    // 2、如果没重写，就走默认内部的逻辑；
    // 3、重写了才会执行 -prefersStatusBarHidden 方法。
    Class metaClass = objc_getMetaClass("UIViewController");
    xz_objc_class_addMethod(metaClass, @selector(doesOverrideViewControllerMethod:), nil, nil, @selector(xz_doesOverrideViewControllerMethod:));
#endif
}

#pragma mark - 状态栏样式

- (UIStatusBarStyle)xz_statusBarStyle {
    if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        NSNumber *value = objc_getAssociatedObject(self, _statusBarStyle);
        if (value != nil) {
            return value.integerValue;
        }
        if (@available(iOS 13, *)) {
            return UIStatusBarStyleDarkContent;
        }
        return UIStatusBarStyleDefault;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return UIApplication.sharedApplication.statusBarStyle;
#pragma clang diagnostic pop
    }
}

- (void)xz_setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    [self xz_setStatusBarStyle:statusBarStyle animated:NO];
}

- (void)xz_setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated {
    if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        objc_setAssociatedObject(self, _statusBarStyle, @(statusBarStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [UIApplication.sharedApplication setStatusBarStyle:statusBarStyle animated:animated];
#pragma clang diagnostic pop
    }
}

#pragma mark - 状态栏显示或隐藏

#if XZ_STATUS_BAR_HIDDEN_MANAGABLE
+ (BOOL)xz_doesOverrideViewControllerMethod:(SEL)method {
    if (method == @selector(prefersStatusBarHidden)) {
        return YES;
    }
    return [self xz_doesOverrideViewControllerMethod:method];
}
#endif

- (BOOL)xz_statusBarHidden {
    if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        NSNumber *value = objc_getAssociatedObject(self, _statusBarHidden);
        if (value != nil) {
            return [value boolValue];
        }
        return NO;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return UIApplication.sharedApplication.statusBarHidden;
#pragma clang diagnostic pop
    }
}

- (void)xz_setStatusBarHidden:(BOOL)statusBarHidden {
    [self xz_setStatusBarHidden:statusBarHidden animated:NO];
}

- (void)xz_setStatusBarHidden:(BOOL)statusBarHidden animated:(BOOL)animated {
    if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        objc_setAssociatedObject(self, _statusBarHidden, @(statusBarHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden animated:animated];
#pragma clang diagnostic pop
    }
}

@end


@implementation UINavigationController (XZKit)

+ (void)load {
    {
        SEL   const sel1 = @selector(childViewControllerForStatusBarStyle);
        SEL   const sel2 = @selector(xz_childViewControllerForStatusBarStyle);
        xz_objc_class_addMethod(UINavigationController.class, sel1, sel2, sel2, sel2);
    }
    {
        SEL   const sel1 = @selector(childViewControllerForStatusBarHidden);
        SEL   const sel2 = @selector(xz_childViewControllerForStatusBarHidden);
        xz_objc_class_addMethod(UINavigationController.class, sel1, sel2, sel2, sel2);
    }
}

- (UIViewController *)xz_childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)xz_childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end


@implementation UITabBarController (XZKit)

+ (void)load {
    {
        SEL const sel1 = @selector(childViewControllerForStatusBarStyle);
        SEL const sel2 = @selector(xz_childViewControllerForStatusBarStyle);
        xz_objc_class_addMethod(UITabBarController.class, sel1, sel2, sel2, sel2);
    }
    {
        SEL const sel1 = @selector(childViewControllerForStatusBarHidden);
        SEL const sel2 = @selector(xz_childViewControllerForStatusBarHidden);
        xz_objc_class_addMethod(UITabBarController.class, sel1, sel2, sel2, sel2);
    }
}

- (UIViewController *)xz_childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

- (UIViewController *)xz_childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}

@end
