//
//  ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "ViewController.h"
@import XZExtensions;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *styleControl;
@property (weak, nonatomic) IBOutlet UISwitch *hiddenControl;

@end

@implementation ViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
        self.styleControl.selectedSegmentIndex = 0;
    } else {
        self.styleControl.selectedSegmentIndex = 1;
    }
    
    self.hiddenControl.on = self.prefersStatusBarHidden;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)styleControlValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self xz_setPreferredStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            break;
        case 1:
            [self xz_setPreferredStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
            break;
        default:
            break;
    }
}

- (IBAction)hiddenControlValueChanged:(UISwitch *)sender {
    [self xz_setPrefersStatusBarHidden:sender.isOn animated:YES];
}

@end
