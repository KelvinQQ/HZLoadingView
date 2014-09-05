//
//  HZLoadingModeView.m
//  HZUIKit
//
//  Created by History on 14-9-5.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZLoadingModeView.h"

const CGFloat kLoadingModeViewRadius = 30.f;
const CGFloat kLoadingCustomViewRadius = 15.f;
const CGFloat kLoadingCircleWidth = 1.5f;
const CGFloat kLoadingAnimationDuration = 1.5f;

NSString * const HZCircleProgressViewAnimationKey = @"HZCircleProgressViewAnimationKey";

@implementation HZLoadingModeView

- (void)startLoading
{
    NSAssert(false, @"Need Overwrite");
}
- (void)stopLoading
{
    NSAssert(false, @"Need Overwrite");
}

- (void)dealloc
{
    [self stopLoading];
}

@end

@interface HZArcLoadingModeView ()
{
    CGFloat _currentDegrees;
}
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *arcLayer;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HZArcLoadingModeView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(50, 50, kLoadingModeViewRadius, kLoadingModeViewRadius)];
    if (self) {
        _customView = [[UIView alloc] init];
        _customView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.backgroundColor = [UIColor clearColor];
        _arcColor = [UIColor redColor];
        
        [self.layer addSublayer:self.circleLayer];
        [self.layer addSublayer:self.arcLayer];
        
        [self startLoading];
    }
    return self;
}

- (CAShapeLayer *)circleLayer
{
    
    if (!_circleLayer) {
        CGFloat cornerRadius = (kLoadingModeViewRadius - 2) / 2.f;
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.frame = self.bounds;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:HZRectGetCenter(self.bounds)
                                                                  radius:cornerRadius
                                                              startAngle:HZDegreesToRadians(0)
                                                                endAngle:HZDegreesToRadians(360)
                                                               clockwise:NO];
        _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _circleLayer.lineWidth = kLoadingCircleWidth;
        _circleLayer.path = circlePath.CGPath;
    }
    
    return _circleLayer;
}

- (CAShapeLayer *)arcLayer
{
    if (!_arcLayer) {
        CGFloat cornerRadius = (kLoadingModeViewRadius - 2) / 2.f;
        _arcLayer = [CAShapeLayer layer];
        _arcLayer.fillColor = [UIColor clearColor].CGColor;
        _arcLayer.frame = self.bounds;
        UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:HZRectGetCenter(self.bounds)
                                                               radius:cornerRadius
                                                           startAngle:HZDegreesToRadians(_currentDegrees)
                                                             endAngle:HZDegreesToRadians(_currentDegrees + 90)
                                                            clockwise:YES];
        _arcLayer.strokeColor = _arcColor.CGColor;
        _arcLayer.lineWidth = kLoadingCircleWidth;
        _arcLayer.path = arcPath.CGPath;
    }
    return _arcLayer;
}

- (void)startLoading
{
    if (_timer) {
        [self stopLoading];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animationLoading) userInfo:nil repeats:YES];
}

- (void)stopLoading
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setArcColor:(UIColor *)arcColor
{
    if (_arcColor != arcColor) {
        _arcColor = arcColor;
        _arcLayer.strokeColor = _arcColor.CGColor;
        [self startLoading];
    }
}

- (void)animationLoading
{
    _currentDegrees += 10;
    CGFloat cornerRadius = (kLoadingModeViewRadius - 2) / 2.f;
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:HZRectGetCenter(self.bounds)
                                                           radius:cornerRadius
                                                       startAngle:HZDegreesToRadians(_currentDegrees)
                                                         endAngle:HZDegreesToRadians(_currentDegrees + 90)
                                                        clockwise:YES];
    _arcLayer.path = arcPath.CGPath;
}

@end

@interface HZCircleLoadingModeView ()
{
    CGFloat _currentDegrees;
}
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HZCircleLoadingModeView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(50, 100, kLoadingModeViewRadius, kLoadingModeViewRadius)];
    if (self) {
        _customView = [[UIView alloc] init];
        _customView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.backgroundColor = [UIColor clearColor];
        _circleColor = [UIColor redColor];
        
        [self.layer addSublayer:self.circleLayer];
        
        [self startLoading];
    }
    return self;
}

- (CAShapeLayer *)circleLayer
{
    
    if (!_circleLayer) {
        CGFloat cornerRadius = (kLoadingModeViewRadius - 2) / 2.f;
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.frame = self.bounds;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:HZRectGetCenter(self.bounds)
                                                                  radius:cornerRadius
                                                              startAngle:HZDegreesToRadians(0)
                                                                endAngle:HZDegreesToRadians(300)
                                                               clockwise:YES];
        _circleLayer.strokeColor = _circleColor.CGColor;
        _circleLayer.lineWidth = kLoadingCircleWidth;
        _circleLayer.path = circlePath.CGPath;
    }
    
    return _circleLayer;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    if (_circleColor != circleColor) {
        _circleColor = circleColor;
        _circleLayer.strokeColor = _circleColor.CGColor;
        [self startLoading];
    }
}


- (void)startLoading
{
    if (_timer) {
        [self stopLoading];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = kLoadingAnimationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [self.circleLayer addAnimation:animation forKey:HZCircleProgressViewAnimationKey];

}

- (void)stopLoading
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(animationLoading) userInfo:nil repeats:YES];
}

- (void)animationLoading
{
    _currentDegrees += 10;
    CGFloat cornerRadius = (kLoadingModeViewRadius - 2) / 2.f;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:HZRectGetCenter(self.bounds)
                                                              radius:cornerRadius
                                                          startAngle:HZDegreesToRadians(_currentDegrees)
                                                            endAngle:HZDegreesToRadians(_currentDegrees + 300)
                                                           clockwise:YES];
    _circleLayer.path = circlePath.CGPath;
}

@end