//
//  CircleProgressBarHandler.m
//  IMSnap
//
//  Created by iMokhles on 14/05/2018.
//

#import "CircleProgressBarHandler.h"

@implementation CircleProgressBarHandler

- (void)startTimerWithSeconds:(long long)arg1 {
    [[self circleProgressBar] setProgress:arg1 animated:NO];
}
- (id)initWithCircleFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        [self createViewWithFrame:frame];
    }
    return self;
}
- (void)createViewWithFrame:(CGRect)frame {
    
    UIView *view1 = [[UIView alloc] initWithFrame:frame];
    [view1 setBackgroundColor:[UIColor clearColor]];
    [view1.layer setCornerRadius:frame.size.height/2.0];
    [view1.layer setMasksToBounds:YES];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:view1.bounds];
    UIBezierPath *bezierPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10, 10) radius:10 startAngle:10 endAngle:10 clockwise:YES];
    [bezierPath appendPath:bezierPath2];
    
    [bezierPath setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[[UIColor blackColor] colorWithAlphaComponent:1] CGColor];
    layer.opacity = 0.5;
    [view1.layer addSublayer:layer];
    
    self.circleProgressBar = [[CircleProgressBar alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.circleProgressBar setBackgroundColor:[UIColor clearColor]];
    [self.circleProgressBar setStartAngle:11];
    [self.circleProgressBar setHintHidden:YES];
    [self.circleProgressBar setProgressBarWidth:0.3];
    [self.circleProgressBar setProgressBarProgressColor:[UIColor clearColor]];
    [self.circleProgressBar setProgressBarTrackColor:[UIColor whiteColor]];
    [view1 addSubview:self.circleProgressBar];
    
    [self setCircleView:view1];
}
@end

