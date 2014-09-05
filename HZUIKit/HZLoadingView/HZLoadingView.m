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
    
}
@property (nonatomic, strong) HZLoadingModeView *loadingModeView;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) HZDismissLoadingViewBlock stopBlock;
@property (nonatomic, assign) HZLoadingMode loadingMode;
@property (nonatomic, assign) HZLoadingType loadingType;
@end

@implementation HZLoadingView

//- (void)startMessageLblAnimation
//{
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateMessage) userInfo:nil repeats:YES];
//}

- (void)commonInit
{
    switch (_loadingMode) {
        case HZLoadingModeDefault: {
            [self defaultInit];
        }
            break;
        case HZLoadingModeTangible: {
            [self tangibleInit];
        }
        default:
            break;
    }
}

- (void)defaultInit
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
    
    if (_stopBlock) {
        UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stopBtn setTitle:@"P" forState:UIControlStateNormal];
        [stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [stopBtn addTarget:self action:@selector(stopLoadingAction) forControlEvents:UIControlEventTouchUpInside];
        stopBtn.frame = CGRectMake(0, 0, 30, 30);
        stopBtn.origin = CGPointMake(_dialogView.width - stopBtn.width - 3, 3);
        [_dialogView addSubview:stopBtn];

    }
}

- (void)tangibleInit
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    [self createLoadingView];
    _loadingModeView.center = self.center;
    [self addSubview:_loadingModeView];
}

- (void)createLoadingView
{
    switch (_loadingType) {
        case HZLoadingTypeArc: {
            _loadingModeView = [[HZArcLoadingModeView alloc] init];
        }
            break;
        case HZLoadingTypeCircle: {
            _loadingModeView = [[HZCircleLoadingModeView alloc] init];
        }
        default:
            break;
    }
}

- (void)stopLoadingAction
{
    if (_stopBlock) {
        _stopBlock(self);
    }
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super initWithFrame:superView.bounds];
    if (self) {
        _loadingType = HZLoadingTypeCircle;
        _loadingMode = HZLoadingModeDefault;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView type:(HZLoadingType)type
{
    self = [super initWithFrame:superView.bounds];
    if (self) {
        _loadingType = type;
        _loadingMode = HZLoadingModeDefault;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView type:(HZLoadingType)type mode:(HZLoadingMode)mode
{
    self = [super initWithFrame:superView.bounds];
    if (self) {
        _loadingType = type;
        _loadingMode = mode;
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
+ (instancetype)showLoadingViewInView:(UIView *)view type:(HZLoadingType)type
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view type:type];
    loadingView.loadingType = type;
    [view addSubview:loadingView];
    return loadingView;
}
+ (instancetype)showLoadingViewInView:(UIView *)view type:(HZLoadingType)type mode:(HZLoadingMode)mode
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view type:type mode:mode];
    [view addSubview:loadingView];
    return loadingView;
}

+ (instancetype)showLoadingViewInView:(UIView *)view stopBlock:(HZDismissLoadingViewBlock)stopBlock
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view];
    loadingView.stopBlock = stopBlock;
    [view addSubview:loadingView];
    return loadingView;
}

+ (instancetype)showLoadingViewInView:(UIView *)view mode:(HZLoadingMode)mode message:(NSString *)message
{
    HZLoadingView *loadingView = [[HZLoadingView alloc] initWithSuperView:view];
    [view addSubview:loadingView];
    return loadingView;
}

+ (void)dismissLoadingViewInView:(UIView *)view
{
    HZLoadingView *loadingView = [HZLoadingView loadingViewInView:view];
    [UIView animateWithDuration:0.2
                     animations:^{
                         loadingView.alpha = 0.f;
                     }
                     completion:^(BOOL finished) {
                         [loadingView removeFromSuperview];
                     }];
    
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
