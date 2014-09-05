//
//  HZLoadingModeView.h
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLoadingModeView : UIView
{
    UIView *_customView;
}
- (void)startLoading;
- (void)stopLoading;
@end

@interface HZArcLoadingModeView : HZLoadingModeView
@property (nonatomic, strong) UIColor *arcColor;
@end

@interface HZCircleLoadingModeView : HZLoadingModeView
@property (nonatomic, strong) UIColor *circleColor;
@end