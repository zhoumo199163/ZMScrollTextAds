//
//  ZMTransformAdsView.m
//  ZMScrollTextAds
//
//  Created by zm on 2016/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMTransformAdsView.h"

@interface ZMTransformAdsView(){
    NSTimer *timer;
    
    UILabel *oneLabel;
    UILabel *twoLabel;
    CGFloat offset;
    
    NSMutableArray *labels;
    NSArray *labelTitles;
    NSInteger titleNumber;
}

@end
@implementation ZMTransformAdsView

- (instancetype)initZMTransformAdsWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if(self){
        labels = [NSMutableArray new];
        offset = frame.size.height * 0.5;
        labelTitles = [NSArray arrayWithArray:titles];
        titleNumber = -1;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    
    [twoLabel setText:[self getLabelTitle]];

    
    [labels addObject:oneLabel];
    [labels addObject:twoLabel];
    
    [self addSubview:oneLabel];
    [self addSubview:twoLabel];
    
    oneLabel.transform = CGAffineTransformConcat(
                                                 // 缩放变换
                                                 CGAffineTransformMakeScale(1, 0),  // frame = (0 25; 414 0)
                                                 // 偏移变换
                                                 CGAffineTransformMakeTranslation(0, offset)
//                                                 CGAffineTransformMakeTranslation(0, -offset)// 向下 frame = (0 0; 414 0)
                                                 );
    
    timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(transformAnimation) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    }

- (void)transformAnimation{

    UILabel *label1 = labels[0];
    UILabel *label2 = labels[1];
    
    [label1 setText:[self getLabelTitle]];


    [UIView animateWithDuration:1.0f animations:^{
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

- (NSString *)getLabelTitle{
    titleNumber = (titleNumber+1 == [labelTitles count])?0:titleNumber+1;
    return labelTitles[titleNumber];
}

@end
