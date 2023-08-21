//
//  ViewController.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "ViewController.h"
@import XZExtensions;
@import XZDefines;

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = XZOpt([NSURL URLWithString:@""], @"https://xezun.com/1");
    XZLog(@"url: %@", url);

    self.view.backgroundColor = rgb(0xe1e2e3);
}


@end
