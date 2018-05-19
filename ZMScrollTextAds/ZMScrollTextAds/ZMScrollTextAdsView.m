//
//  ZMScrollTextAdsView.m
//  ZMScrollTextAds
//
//  Created by zm on 16/6/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMScrollTextAdsView.h"

// 文字滚动时间
static const CGFloat SCROLL_TIME = 1.0f;
// 文字展示时间
static const CGFloat SHOW_TIME = 3.0f;


@interface ZMScrollTextAdsView()<UIScrollViewDelegate>{
    CGFloat selfHeight;
    CGFloat selfWidth;
    
    NSInteger currentNum;//记录当前显示的是哪条text
    BOOL isNeedScrolling;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZMScrollTextAdsView

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray *)array{
    self = [super initWithFrame:frame];
    if(self){
        if(array.count != 0){
            self.dataSources = [NSArray arrayWithArray:array];
            if(array.count >1){
                isNeedScrolling = YES;
            }
            selfHeight = self.frame.size.height;
            selfWidth = self.frame.size.width;
            [self.scrollView addSubview:self.topLabel];
            [self.scrollView addSubview:self.bottomLabel];
            [self addSubview:self.scrollView];
            [self startTime];
        }
    }
    return self;
}


//开启计时
- (void)startTime{
    self.topLabel.text = [self.dataSources firstObject];
    if(!isNeedScrolling) return;
    self.bottomLabel.text = [self.dataSources objectAtIndex:1];
    if([self.timer isValid]){
        [self endTime];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:SHOW_TIME target:self selector:@selector(scrollToNextLabel) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endTime{
    [self.timer invalidate];
    self.timer = nil;
    currentNum = 0;
}

- (void)scrollToNextLabel{
    [UIView animateWithDuration:SCROLL_TIME animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, selfHeight)];
    } completion:^(BOOL finished) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
         [self reloadLabelText:currentNum];
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:SHOW_TIME]];
    }];
    
}

- (void)reloadLabelText:(NSInteger)num{
    NSInteger nextNum;
    
    if(num == [self.dataSources count] -1){
        num = 0;
        nextNum = num + 1;
    }
    else{
        num = num  +1;
        nextNum = (num+1)== self.dataSources.count?0:num+1;
    }
    
    [self.topLabel setText:self.dataSources[num]];
    [self.bottomLabel setText:self.dataSources[nextNum]];
    
    currentNum = num;
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tap{
    if(self.ZMDelegate && [self.ZMDelegate respondsToSelector:@selector(didSelectedLableAtIndex:)]){
        [self.ZMDelegate didSelectedLableAtIndex:currentNum+1];
    }
}

#pragma mark - GET
- (UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfWidth,selfHeight)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [scrollView setBackgroundColor:[UIColor whiteColor]];
        scrollView.scrollEnabled = NO;
        [scrollView setContentSize:CGSizeMake(0 ,self.dataSources.count ==1?selfHeight:2*selfHeight)];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UILabel *)topLabel{
    if(!_topLabel){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [label setBackgroundColor:[UIColor whiteColor]];
        UITapGestureRecognizer *tapGesureTecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [label addGestureRecognizer:tapGesureTecognizer];
        _topLabel = label;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel{
    if(!_bottomLabel){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth, selfHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [label setBackgroundColor:[UIColor whiteColor]];
        _bottomLabel = label;
    }
    return _bottomLabel;
}



@end
