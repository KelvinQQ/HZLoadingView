//
//  HZViewController.m
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZViewController.h"
#import "HZLoadingModeView.h"
#import "HZLoadingView.h"

@interface HZViewController ()

@end

@implementation HZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [HZLoadingView showLoadingViewInView:self.view stopBlock:^(HZLoadingView *loadingView) {
        [HZLoadingView dismissLoadingViewInView:self.view];
        NSLog(@"Stop Block");
    }];
//    [HZLoadingView showLoadingViewInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
