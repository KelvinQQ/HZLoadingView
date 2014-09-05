//
//  HZLoadingView.m
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZLoadingView.h"
#import "HZLoadingModeView.h"

const CGFloat kLoadingDialogWidth = 240.f;
const CGFloat kLoadingDialogHeight = 80.f;

@interface HZLoadingView ()
{
    HZLoadingMode _loadingMode;
}
@property (nonatomic, strong) HZLoadingModeView *loadingModeView;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UILabel *messageLbl;
@end

@implementation HZLoadingView

//- (void)startMessageLblAnimation
//{
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateMessage) userInfo:nil repeats:YES];
//}

- (void)commonInit
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _dialogView = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, CGSizeMake(kLoadingDialogWidth, kLoadingDialogHeight) }];
    _dialogView.center = HZRectGetCenter(self.bounds);
    _dialogView.backgroundColor = [UIColor whiteColor];
    _dialogView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _dialogView.layer.cornerRadius = 5.f;
    [self addSubview:_dialogView];
    
    [self createLoadingView];
    _loadingModeView.center = CGPointMake(CGRectGetWidth(_loadingModeView.bounds) / 2 + 30, CGRectGetMidY(_dialogView.bounds));
    [_dialogView addSubview:_loadingModeView];
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_loadingModeView.frame),
                                                                    0,
                                                                    CGRectGetWidth(_dialogView.frame) - CGRectGetWidth(_loadingModeView.frame) - 30,
                                                                    CGRectGetHeight(_dialogView.frame))];
    _messageLbl.backgroundColor = [UIColor clearColor];
    _messageLbl.text = _message.length ? _message : @"正在加载...";
    _messageLbl.textAlignment = NSTextAlignmentCenter;
    [_dialogView addSubview:_messageLbl];
}

- (void)createLoadingView
{
    switch (_loadingMode) {
        case HZLoadingModeArc: {
            _loadingModeView = [[HZArcLoadingModeView alloc] init];
        }
            break;
        case HZLoadingModeCircle: {
            _loadingModeView = [[HZCircleLoadingModeView alloc] init];
        }
        default:
            break;
    }
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super initWithFrame:superView.bounds];
    if (self) {
        _loadingMode = HZLoadingModeCircle;
        [self commonInit];
    }
    return self;
}

+ (instancetype)showLoadingViewInView:(UIView *)view
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view];
    [view addSubview:loadingView];
    return loadingView;
}

+ (instancetype)showLoadingViewInView:(UIView *)view mode:(HZLoadingMode)mode
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view];
    [view addSubview:loadingView];
    return loadingView;
}

+ (instancetype)showLoadingViewInView:(UIView *)view mode:(HZLoadingMode)mode message:(NSString *)message
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view];
    [view addSubview:loadingView];
    return loadingView;
}

- (void)dismissLoadingViewInView:(UIView *)view
{
    HZLoadingView *loadingView = [HZLoadingView loadingViewInView:view];
    [loadingView removeFromSuperview];
}
+ (void)dismissAllLoadingViewInView:(UIView *)view
{
    
}

+ (HZLoadingView *)loadingViewInView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[HZLoadingView class]]) {
            return (HZLoadingView *)subView;
        }
    }
    return nil;
}
+ (NSArray *)allLoadingViewInView:(UIView *)view
{
    NSMutableArray *loadingViews = [NSMutableArray array];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[HZLoadingView class]]) {
            [loadingViews addObject:subView];
        }
    }
    return loadingViews;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
