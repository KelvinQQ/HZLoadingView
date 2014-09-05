//
//  HZLoadingView.h
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZLoadingView;

typedef void(^HZDismissLoadingViewBlock)(HZLoadingView *loadingView);

typedef NS_ENUM(NSInteger, HZLoadingType) {
    HZLoadingTypeArc,
    HZLoadingTypeCircle
};

typedef NS_ENUM(NSInteger, HZLoadingMode) {
    HZLoadingModeDefault,
    HZLoadingModeTangible
};
@interface HZLoadingView : UIView
{

}
+ (instancetype)showLoadingViewInView:(UIView *)view;
+ (instancetype)showLoadingViewInView:(UIView *)view stopBlock:(HZDismissLoadingViewBlock)stopBlock;
+ (void)dismissLoadingViewInView:(UIView *)view;
+ (void)dismissAllLoadingViewInView:(UIView *)view;
@end
