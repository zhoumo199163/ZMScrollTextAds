//
//  ZMTransformAdsView.h
//  ZMScrollTextAds
//
//  Created by zm on 2016/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMTransformAdsView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray *)array;
- (void)startTime;
- (void)endTime;
@end
