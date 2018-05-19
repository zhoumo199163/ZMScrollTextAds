//
//  ZMTransformAdsView.m
//  ZMScrollTextAds
//
//  Created by zm on 2016/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMTransformAdsView.h"

// 文字滚动时间
static const CGFloat SCROLL_TIME = 1.0f;
// 文字展示时间
static const CGFloat SHOW_TIME = 4.0f;

@interface ZMTransformAdsView(){
    CGFloat offset;
    
    NSMutableArray *labels;
    NSInteger titleNumber;
}

@property (nonatomic, strong) UILabel *oneLabel;
@property (nonatomic, strong) UILabel *twoLabel;

@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ZMTransformAdsView

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray *)array{
    self = [super initWithFrame:frame];
    if(self){
        labels = [NSMutableArray new];
        offset = frame.size.height * 0.5;
        self.dataSources = [NSArray arrayWithArray:array];
        titleNumber = -1;
        
         [self.twoLabel setText:[self getData]];
    
        [labels addObject:self.oneLabel];
        [labels addObject:self.twoLabel];
        
        [self addSubview:self.oneLabel];
        [self addSubview:self.twoLabel];
        
        [self initTransform];
        [self startTime];
    }
    return self;
}

- (void)initTransform{
    self.oneLabel.transform = CGAffineTransformConcat(
                                                      // 缩放变换
                                                      CGAffineTransformMakeScale(1, 0),  // frame = (0 25; 414 0)
                                                      // 偏移变换
                                                      CGAffineTransformMakeTranslation(0, offset)
                                                      //                                                 CGAffineTransformMakeTranslation(0, -offset)// 向下 frame = (0 0; 414 0)
                                                      );
}

- (void)startTime{
    
    if(self.dataSources.count <= 1){
        return;
    }
    if([self.timer isValid]){
        [self endTime];
    }
    self.timer = [NSTimer timerWithTimeInterval:SHOW_TIME target:self selector:@selector(transformAnimation) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endTime{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)transformAnimation{
    
    UILabel *label1 = labels[0];
    UILabel *label2 = labels[1];
    
    [label1 setText:[self getData]];
    
    [UIView animateWithDuration:SCROLL_TIME animations:^{
        ///  还原label1的变换状态并形变和偏移label2
        label1.transform = CGAffineTransformIdentity;
        label2.transform = CGAffineTransformConcat(
                                                   CGAffineTransformMakeScale(1, 0.05),
                                                   CGAffineTransformMakeTranslation(0, -offset)
                                                   //                                                   CGAffineTransformMakeTranslation(0, offset)
                                                   );
    } completion:^(BOOL finished) {
        label2.transform = CGAffineTransformConcat(
                                                   CGAffineTransformMakeScale(1, 0),
                                                   CGAffineTransformMakeTranslation(0, offset)
                                                   //                                                   CGAffineTransformMakeTranslation(0, -offset)
                                                   );
        [labels removeAllObjects];
        [labels addObject:label2];
        [labels addObject:label1];
        
    }];
    
    
}

- (NSString *)getData{
    titleNumber = (titleNumber +1 == [self.dataSources count])?0:titleNumber+1;
    return self.dataSources[titleNumber];
}

#pragma mark - GET
- (UILabel *)oneLabel{
    if(!_oneLabel){
        _oneLabel = [self newLabel];
    }
    return _oneLabel;
}

- (UILabel *)twoLabel{
    if(!_twoLabel){
        _twoLabel = [self newLabel];
    }
    return _twoLabel;
}

- (UILabel *)newLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}



@end
