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

/**
 *  初始化
 *
 *  @param frame
 *  @param array
 *
 *  @return
 */
- (instancetype)initScrollTextAdsFrame:(CGRect)frame
                        labelTextArray:(NSArray *)array;

@end
