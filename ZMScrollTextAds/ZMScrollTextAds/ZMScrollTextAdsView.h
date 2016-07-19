//
//  ZMScrollTextAdsView.h
//  ZMScrollTextAds
//
//  Created by zm on 16/6/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMScrollTextAdsView;
@protocol ZMScrollTextAdsViewDelegate <NSObject>

// 点击label代理
- (void)clickedLabelWithNum:(NSInteger)num;

@end

@interface ZMScrollTextAdsView : UIView

@property (nonatomic ,assign) id<ZMScrollTextAdsViewDelegate> ZMDelegate;

@property (nonatomic) BOOL openUserInteractionEnabled;

/**
 *  初始化
 *
 *  @param frame
 *  @param array
 *  @param time      滚动间隔时间
 *  @param pauseTime label停顿时间 注：滚动间隔时间 - 停顿时间 = label滚动动画时间
 *
 *  @return
 */
- (instancetype)initScrollTextAdsFrame:(CGRect)frame
                        labelTextArray:(NSArray *)array
                    scrollTimeInterval:(CGFloat)time
                             pauseTime:(CGFloat)pauseTime;

@end
