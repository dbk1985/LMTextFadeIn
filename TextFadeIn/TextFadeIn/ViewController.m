//
//  ViewController.m
//  TextFadeIn
//
//  Created by by on 15/12/24.
//  Copyright © 2015年 dlm. All rights reserved.
//

#import "ViewController.h"
#import "LMTextFadeInView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMTextFadeInView *fadeInView = [[LMTextFadeInView alloc] initWithFrame:CGRectMake(20, 120, 280, 200)];
    fadeInView.text = @"惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色。取之无禁，用之不竭。是造物者之无尽藏也，而吾与子之所共适。";
    [self.view addSubview:fadeInView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
