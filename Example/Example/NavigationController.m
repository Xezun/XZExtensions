//
//  NavigationController.m
//  Example
//
//  Created by 徐臻 on 2024/9/10.
//

#import "NavigationController.h"
@import XZExtensions;

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage xz_imageWithColor:UIColor.orangeColor];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundImage = image;
        appearance.titleTextAttributes = @{ NSForegroundColorAttributeName: UIColor.whiteColor };
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        [self.navigationBar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
