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
    
    CGFloat scrollTime;//scroll滚动间隔
    NSInteger currentNum;//记录当前显示的是哪条text
    CGFloat labelPauseTime;//label停顿展示时间
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) NSArray *labelTextArray;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZMScrollTextAdsView

- (instancetype)initScrollTextAdsFrame:(CGRect)frame labelTextArray:(NSArray *)array scrollTimeInterval:(CGFloat)time pauseTime:(CGFloat)pauseTime{
    self = [super initWithFrame:frame];
    if(self){
        if(array.count != 0){
            self.labelTextArray = [NSArray arrayWithArray:array];
            scrollTime = time;
            labelPauseTime = pauseTime<scrollTime?pauseTime:scrollTime/2;
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
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.scrollView setBackgroundColor:[UIColor redColor]];
    self.scrollView.userInteractionEnabled = self.openUserInteractionEnabled;
    [self.scrollView setContentSize:CGSizeMake(0 ,self.labelTextArray.count ==1?selfHeight:2*selfHeight)];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [self addSubview:self.scrollView];
    
}

- (void)initScrollWithLabels:(NSArray *)array{
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
    self.topLabel.text = [array firstObject];
    self.topLabel.userInteractionEnabled = YES;
    [self.topLabel setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:self.topLabel];
    currentNum = 0;
    UITapGestureRecognizer *tapGesureTecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.topLabel addGestureRecognizer:tapGesureTecognizer];
    
    
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth, selfHeight)];
    self.bottomLabel.text = [array objectAtIndex:1];
    [self.bottomLabel setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:self.bottomLabel];
}

//开启计时
- (void)startTime{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:scrollTime target:self selector:@selector(scrollToNextLabel) userInfo:nil repeats:YES];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)endTime{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollToNextLabel{

    [UIView animateWithDuration:(scrollTime-labelPauseTime) animations:^{
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
    
    [self.topLabel setText:self.labelTextArray[num]];
    [self.bottomLabel setText:self.labelTextArray[nextNum]];
    
    currentNum = num;
}

- (void)handleTap:(UITapGestureRecognizer *)tap{
    if(self.ZMDelegate && [self.ZMDelegate respondsToSelector:@selector(clickedLabelWithNum:)]){
        [self.ZMDelegate clickedLabelWithNum:currentNum+1];
    }
}



@end
