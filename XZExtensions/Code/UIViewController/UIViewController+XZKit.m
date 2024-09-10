//
//  UIViewController+XZKit.m
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import "UIViewController+XZKit.h"
#import <objc/runtime.h>
#import "UIApplication+XZKit.h"

#define XZ_STATUS_BAR_MANAGABLE 0

static const void * const _isStatusBarAppearanceManageable = &_isStatusBarAppearanceManageable;
static const void * const _preferredStatusBarStyle = &_preferredStatusBarStyle;
static const void * const _prefersStatusBarHidden = &_prefersStatusBarHidden;

@implementation UIViewController (XZKit)

- (BOOL)xz_canManageStatusBarAppearance {
    return objc_getAssociatedObject(self.class, _isStatusBarAppearanceManageable);
}

- (BOOL)xz_setManageStatusBarAppearance {
    Class const aClass = self.class;
    if (objc_getAssociatedObject(aClass, _isStatusBarAppearanceManageable)) {
        return NO;
    }
    objc_setAssociatedObject(aClass, _isStatusBarAppearanceManageable, @(YES), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    BOOL isViewControllerBased = UIApplication.xz_isViewControllerBasedStatusBarAppearance;
    NSAssert(isViewControllerBased, @"必须先配置 Info.plist 中键 UIViewControllerBasedStatusBarAppearance 的值 YES 才能管理开启状态栏。");
    
    Class const source = UIViewController.class;
    
    {
        SEL const selector = @selector(xz_prefersStatusBarHidden);
        xz_objc_class_addMethod(aClass, @selector(prefersStatusBarHidden), source, selector, selector, selector);
    }
    
    {
        SEL const selector = @selector(xz_preferredStatusBarStyle);
        xz_objc_class_addMethod(aClass, @selector(preferredStatusBarStyle), source, selector, selector, selector);
    }
    return YES;
}

#pragma mark - 状态栏样式

- (UIStatusBarStyle)xz_preferredStatusBarStyle {
    if (self.xz_canManageStatusBarAppearance) {
        NSNumber *value = objc_getAssociatedObject(self, _preferredStatusBarStyle);
        if (value != nil) {
            return value.integerValue;
        }
        if (@available(iOS 13, *)) {
            return UIStatusBarStyleDarkContent;
        }
        return UIStatusBarStyleDefault;
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
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

- (void)xz_setPreferredStatusBarStyle:(UIStatusBarStyle)xz_preferredStatusBarStyle {
    [self xz_setPreferredStatusBarStyle:xz_preferredStatusBarStyle animated:NO];
}

- (void)xz_setPreferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle animated:(BOOL)animated {
    if ([self xz_canManageStatusBarAppearance]) {
        objc_setAssociatedObject(self, _preferredStatusBarStyle, @(preferredStatusBarStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        [self xz_setManageStatusBarAppearance];
        [self xz_setPreferredStatusBarStyle:preferredStatusBarStyle animated:animated];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [UIApplication.sharedApplication setStatusBarStyle:preferredStatusBarStyle animated:animated];
#pragma clang diagnostic pop
    }
}

#pragma mark - 状态栏显示或隐藏

- (BOOL)xz_prefersStatusBarHidden {
    if ([self xz_canManageStatusBarAppearance]) {
        NSNumber *value = objc_getAssociatedObject(self, _prefersStatusBarHidden);
        if (value != nil) {
            return [value boolValue];
        }
        return NO;
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        return NO;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return UIApplication.sharedApplication.statusBarHidden;
#pragma clang diagnostic pop
    }
}

- (void)xz_setPrefersStatusBarHidden:(BOOL)xz_prefersStatusBarHidden {
    [self xz_setPrefersStatusBarHidden:xz_prefersStatusBarHidden animated:NO];
}

- (void)xz_setPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden animated:(BOOL)animated {
    if ([self xz_canManageStatusBarAppearance]) {
        objc_setAssociatedObject(self, _prefersStatusBarHidden, @(prefersStatusBarHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        [self xz_setManageStatusBarAppearance];
        [self xz_setPrefersStatusBarHidden:prefersStatusBarHidden animated:animated];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:prefersStatusBarHidden animated:animated];
#pragma clang diagnostic pop
    }
}

@end
