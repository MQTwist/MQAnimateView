//
//  ViewController.m
//  MQAnimation
//
//  Created by ma qi on 2020/10/26.
//

#import "ViewController.h"
#import "MQView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *beforeBtn;
@property (nonatomic, strong) UIButton *afterBtn;
@property (nonatomic, strong) MQView *mqView;

@end

@implementation ViewController

/** 解决重点，在beforeBtn、afterBtn的【父视图】上重写 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CGRect afterFrame = self.afterBtn.layer.presentationLayer.frame;
    if (CGRectContainsPoint(afterFrame, point)) {
        [self afterAnimationAction];
    }
}


#pragma mark -
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [self buttonWithFrame:CGRectMake(20, 100, 60, 50) title:@"处理前" action:@selector(before:)];
    [self.view addSubview:btn1];
    UIButton *btn2 = [self buttonWithFrame:CGRectMake(100, 100, 60, 50) title:@"处理后" action:@selector(after:)];
    [self.view addSubview:btn2];
    UIButton *btn3 = [self buttonWithFrame:CGRectMake(180, 100, 60, 50) title:@"自定义" action:@selector(custom:)];
    [self.view addSubview:btn3];
    
    UIButton *beforeBtn = [self buttonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 200, 100, 50) title:@"处理前动画" action:@selector(beforeAnimationAction)];
    [self.view addSubview:beforeBtn];
    self.beforeBtn = beforeBtn;
    UIButton *afterBtn = [self buttonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 300, 100, 50) title:@"处理后动画" action:@selector(afterAnimationAction)];
    [self.view addSubview:afterBtn];
    self.afterBtn = afterBtn;
    MQView *view = [[MQView alloc] initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 50)];
    view.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:view];
    self.mqView = view;
}

#pragma mark -
#pragma mark - action ---> button

- (void)before:(UIButton *)sender {
    NSLog(@">>>before");
    [self animateWithButton:self.beforeBtn];
}

- (void)after:(UIButton *)sender {
    NSLog(@">>>after");
    [self animateWithButton:self.afterBtn];
}

- (void)custom:(UIButton *)sender {
    NSLog(@">>>custom");
    [self.mqView viewAnimation];
}


- (void)beforeAnimationAction {
    NSLog(@">>>beforeAnimationAction");
    
}

- (void)afterAnimationAction {
    NSLog(@">>>afterAnimationAction");
}


#pragma mark -
#pragma mark - factory

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
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


@end
