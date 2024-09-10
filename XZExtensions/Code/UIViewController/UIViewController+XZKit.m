//
//  UIViewController+XZKit.m
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import "UIViewController+XZKit.h"
#import "UIApplication+XZKit.h"
@import ObjectiveC;

#define XZ_STATUS_BAR_MANAGABLE 0

static const void * const _isStatusBarAppearanceManageable = &_isStatusBarAppearanceManageable;
static const void * const _preferredStatusBarStyle = &_preferredStatusBarStyle;
static const void * const _prefersStatusBarHidden = &_prefersStatusBarHidden;

@implementation UIViewController (XZKit)

- (BOOL)xz_prefersStatusBarAppearance {
    return objc_getAssociatedObject(self.class, _isStatusBarAppearanceManageable);
}

/// 开启控制器管理状态栏。
/// @note 本方法会在设置属性 `xz_preferredStatusBarStyle`、`xz_prefersStatusBarHidden` 时自动调用。
/// @returns 返回 YES 表示执行了开启状态栏管理的操作，返回 NO 表示已开启，本次调用未执行任何操作。
- (BOOL)xz_managesStatusBarAppearance {
    Class const aClass = self.class;
    if (objc_getAssociatedObject(aClass, _isStatusBarAppearanceManageable)) {
        return NO;
    }
    objc_setAssociatedObject(aClass, _isStatusBarAppearanceManageable, @(YES), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    NSAssert(UIApplication.xz_isViewControllerBasedStatusBarAppearance, @"必须先配置 Info.plist 中键 UIViewControllerBasedStatusBarAppearance 的值 YES 才能管理开启状态栏。");
    
    xz_objc_class_addMethodWithBlock(aClass, @selector(prefersStatusBarHidden), nil, nil, ^BOOL(UIViewController *self) {
        // 如果是重写方法，不调用超类。
        return self.xz_prefersStatusBarHidden;
    }, ^id (SEL selector) {
        // 如果是交换方法，则调用超类，避免超类的逻辑丢失。
        return ^BOOL(UIViewController *self) {
            ((BOOL *(*)(UIViewController *, SEL))objc_msgSend)(self, selector);
            return self.xz_prefersStatusBarHidden;
        };
    });
    
    xz_objc_class_addMethodWithBlock(aClass, @selector(preferredStatusBarStyle), nil, nil, ^UIStatusBarStyle(UIViewController *self) {
        // 如果是重写方法，不调用超类。
        return self.xz_preferredStatusBarStyle;
    }, ^id (SEL selector) {
        // 如果是交换方法，则调用超类，避免超类的逻辑丢失。
        return ^UIStatusBarStyle(UIViewController *self) {
            ((BOOL *(*)(UIViewController *, SEL))objc_msgSend)(self, selector);
            return self.xz_preferredStatusBarStyle;
        };
    });
    
    return YES;
}

#pragma mark - 状态栏样式

- (UIStatusBarStyle)xz_preferredStatusBarStyle {
    if (self.xz_prefersStatusBarAppearance) {
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
    if ([self xz_prefersStatusBarAppearance]) {
        objc_setAssociatedObject(self, _preferredStatusBarStyle, @(preferredStatusBarStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        [self xz_managesStatusBarAppearance];
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
    if ([self xz_prefersStatusBarAppearance]) {
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
    if ([self xz_prefersStatusBarAppearance]) {
        objc_setAssociatedObject(self, _prefersStatusBarHidden, @(prefersStatusBarHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        } else {
            [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if (UIApplication.xz_isViewControllerBasedStatusBarAppearance) {
        [self xz_managesStatusBarAppearance];
        [self xz_setPrefersStatusBarHidden:prefersStatusBarHidden animated:animated];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarHidden:prefersStatusBarHidden animated:animated];
#pragma clang diagnostic pop
    }
}

@end
