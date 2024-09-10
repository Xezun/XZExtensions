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
    
    self.navigationBar.barTintColor = UIColor.brownColor;
    
    UIImage *image = [UIImage xz_imageWithColor:UIColor.brownColor];
    
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundImage = image;
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
