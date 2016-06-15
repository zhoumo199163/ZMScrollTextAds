//
//  ViewController.m
//  ZMScrollTextAds
//
//  Created by zm on 16/6/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewController.h"
#import "ZMScrollTextAdsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = [NSArray arrayWithObjects:@"第一条巴拉巴拉",@"第二条哈哈哈哈", @"第三条哇哇哇哇",@"第四条啦啦啦啦啦啦",nil];
    ZMScrollTextAdsView *view = [[ZMScrollTextAdsView alloc] initScrollTextAdsFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) labelTextArray:array scrollTimeInterval:3.0f];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
