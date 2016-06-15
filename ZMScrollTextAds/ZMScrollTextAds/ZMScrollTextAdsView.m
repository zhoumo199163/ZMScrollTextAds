//
//  ZMScrollTextAdsView.m
//  ZMScrollTextAds
//
//  Created by zm on 16/6/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMScrollTextAdsView.h"

@interface ZMScrollTextAdsView()<UIScrollViewDelegate>{
    CGFloat selfHeight;
    CGFloat selfWidth;
    
    CGFloat scrollTime;
    NSInteger currentNum;//记录当前显示的是哪条text
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) NSArray *labelTextArray;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZMScrollTextAdsView

- (instancetype)initScrollTextAdsFrame:(CGRect)frame labelTextArray:(NSArray *)array scrollTimeInterval:(CGFloat)time{
    self = [super initWithFrame:frame];
    if(self){
        if(array.count != 0){
            self.labelTextArray = [NSArray arrayWithArray:array];
            scrollTime = time;
            selfHeight = self.frame.size.height;
            selfWidth = self.frame.size.width;
            
            [self initScrollView];
            [self initScrollWithLabels:self.labelTextArray];
            [self startTime];
        }
    }
    return self;
}


//初始化ScrollView
- (void)initScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfWidth,selfHeight)];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(0 ,self.labelTextArray.count ==1?selfHeight:2*selfHeight)];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [self addSubview:self.scrollView];
    
}

- (void)initScrollWithLabels:(NSArray *)array{
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
    self.topLabel.text = [array firstObject];
    self.topLabel.backgroundColor = [UIColor purpleColor];
    [self.scrollView addSubview:self.topLabel];
    currentNum = 0;
    
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth, selfHeight)];
    self.bottomLabel.text = [array objectAtIndex:1];
    self.bottomLabel.backgroundColor = [UIColor purpleColor];
    [self.scrollView addSubview:self.bottomLabel];
}

//开启计时
- (void)startTime{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:scrollTime target:self selector:@selector(scrollToNextLabel) userInfo:nil repeats:YES];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollToNextLabel{

    [UIView animateWithDuration:scrollTime/2 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, selfHeight)];
        
    } completion:^(BOOL finished) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
         [self reloadLabelText:currentNum];
       
    }];
    
}

- (void)reloadLabelText:(NSInteger)num{
    
    NSInteger nextNum;
    
    if(num == [self.labelTextArray count] -1){
        num = 0;
        nextNum = num + 1;
    }
    else{
        num = num  +1;
        nextNum = (num+1)== self.labelTextArray.count?0:num+1;
    }
    
    NSLog(@"num:%ld",(long)num);
    [self.topLabel setText:self.labelTextArray[num]];
    [self.bottomLabel setText:self.labelTextArray[nextNum]];
    
    currentNum = num;
}


@end
