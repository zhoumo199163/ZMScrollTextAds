//
//  ViewController.m
//  ZMScrollTextAds
//
//  Created by zm on 16/6/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewController.h"
#import "ZMScrollTextAdsView.h"
#import "ZMTransformAdsView.h"

@interface ViewController ()<ZMScrollTextAdsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *array = [NSArray arrayWithObjects:@"Spring",@"Summer", @"Autumn",@"Winter",nil];
    ZMScrollTextAdsView *textAdsView = [[ZMScrollTextAdsView alloc] initScrollTextAdsFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) labelTextArray:array];
    textAdsView.ZMDelegate = self;
    [self.view addSubview:textAdsView];
    
    ZMTransformAdsView *transformView =[[ZMTransformAdsView alloc] initZMTransformAdsWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50) titles:array];
    
    transformView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:transformView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickedLabelWithNum:(NSInteger)num{
    NSLog(@"点击第%ld个label",(long)num);
}

@end
