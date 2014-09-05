//
//  UIView+Extension.h
//  HZExtensionKit
//
//  Created by History on 14-4-27.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;

@end

@interface UIView (Capture)

- (UIImage *)capture;
- (UIImage *)captureWithRect:(CGRect)rect;

@end

@interface UIView (Extension)

- (UIViewController *)viewController;
+ (UIView *)appTopView;

- (void)removeAllSubViews;
@end
