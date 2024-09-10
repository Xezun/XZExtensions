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
    
    UIImage *image = [UIImage xz_imageWithColor:UIColor.brownColor];
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundImage = image;
    appearance.titleTextAttributes = @{ NSForegroundColorAttributeName: UIColor.whiteColor };
    self.navigationBar.standardAppearance = appearance;
    self.navigationBar.scrollEdgeAppearance = appearance;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end