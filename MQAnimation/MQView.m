//
//  MQView.m
//  MQAnimation
//
//  Created by ma qi on 2020/10/27.
//

#import "MQView.h"

@interface MQView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation MQView

/** 解决重点，在button【父视图】上重写 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    CGRect buttonFrame = self.button.layer.presentationLayer.frame;
    if (CGRectContainsPoint(buttonFrame, point)) {
        [self action];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [self buttonWithFrame:CGRectMake(frame.size.width, 0, 100, frame.size.height) title:@"在某个视图上" action:@selector(action)];
        [self addSubview:button];
        self.button = button;
    }
    return self;
}

#pragma mark -
#pragma mark - tool

- (void)viewAnimation {
    [self animateWithButton:self.button];
}

#pragma mark -
#pragma mark - action ---> button

- (void)action {
    NSLog(@">>>在父视图上button action");
}

- (void)animateWithButton:(UIButton *)sender {
    CGFloat duration = 5 / 3.;
    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:duration animations:^{
            CGRect frame = sender.frame;
            frame.origin.x = [UIScreen mainScreen].bounds.size.width / 2.;
            sender.frame = frame;
        }];
        [UIView addKeyframeWithRelativeStartTime:1 / 3. relativeDuration:duration animations:^{
            CGRect frame = sender.frame;
            frame.origin.x = [UIScreen mainScreen].bounds.size.width / 2. - 30;
            sender.frame = frame;
        }];
        [UIView addKeyframeWithRelativeStartTime:2 / 3. relativeDuration:duration animations:^{
            CGRect frame = sender.frame;
            frame.origin.x = -frame.size.width;
            sender.frame = frame;
        }];
    } completion:^(BOOL finished) {
        CGRect frame = sender.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width;
        sender.frame = frame;
    }];
}

#pragma mark -
#pragma mark - factory

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
