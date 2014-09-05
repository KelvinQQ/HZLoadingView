//
//  HZLoadingView.h
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HZLoadingMode) {
    HZLoadingModeArc,
    HZLoadingModeCircle
};

@interface HZLoadingView : UIView
+ (instancetype)showLoadingViewInView:(UIView *)view;
+ (void)dismissLoadingViewInView:(UIView *)view;
+ (void)dismissAllLoadingViewInView:(UIView *)view;
@end
