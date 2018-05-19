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

- (void)didSelectedLableAtIndex:(NSInteger)index;

@end

@interface ZMScrollTextAdsView : UIView

@property (nonatomic ,assign) id<ZMScrollTextAdsViewDelegate> ZMDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray *)array;
/**
 开启计时 - 重新滚动
 */
- (void)startTime;
/**
 结束计时 - 清理数据
 */
- (void)endTime;

@end
