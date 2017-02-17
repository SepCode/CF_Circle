//
//  ViewController.m
//  12-CAAnimation
//
//  Created by ChuanYou on 16/8/1.
//  Copyright © 2016年 CF. All rights reserved.
//

#import "ViewController.h"

#define angle2Rad(angle) (angle / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIImageView *heart;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
/*
fade
交叉淡化过渡
 
push
新视图把旧视图推出去 
 
moveIn
新视图移到旧视图上面
 
reveal
将旧视图移开,显示下面的新视图 
 
cube
立方体翻滚效果
 
oglFlip
上下左右翻转效果
 
suckEffect
收缩效果，如一块布被抽走
 
rippleEffect
水滴效果
 
pageCurl
向上翻页效果
 
pageUnCurl
向下翻页效果
 
cameraIrisHollowOpen
相机镜头打开效果
 
cameraIrisHollowClose
相机镜头关闭效果

*/
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.heart.frame.size.width * 0.5, self.heart.frame.size.width * 0.5) radius:self.heart.frame.size.width * 0.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.repeatCount = MAXFLOAT;
    // 设置layer的animation
    [shapeLayer addAnimation:animation forKey:nil];
//    
//    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation2.fromValue = @(1.0);
//    animation2.toValue = @(0.0);
//    //shapeLayer.autoreverses = NO;
//    //animation2.duration = 3.0;
//
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(angle2Rad(360));
    anim.repeatCount = MAXFLOAT;
    //anim.autoreverses = YES;
    anim.duration = 1;
    
    
//    group.animations = @[anim];
//    group.repeatCount = MAXFLOAT;
//    group.autoreverses = YES;
    // 设置layer的animation
    
    
    
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim2.keyPath = @"strokeColor";
    
    NSValue *v1 = (id)[UIColor blueColor].CGColor;
    
    NSValue *v2 = (id)[UIColor redColor].CGColor;
    
    NSValue *v3 = (id)[UIColor greenColor].CGColor;
    
    anim2.values = @[v1,v2,v3];
    
    anim2.duration = 3;

    anim2.repeatCount = MAXFLOAT;
//    CALayer *layer =[[CALayer alloc] init];
//    
//    [layer addAnimation:anim2 forKey:nil];
//    
//    //shapeLayer.mask = layer;
    
    [shapeLayer addAnimation:anim2 forKey:nil];
    

    [self.heart.layer addSublayer:shapeLayer];
    [self.heart.layer addAnimation:anim forKey:nil];
    
    
    
//    CATransition *anim = [CATransition animation];
//    
//    [self.heart setImage:[UIImage imageNamed:@"心"]];
//    
//    anim.type = @"pageCurl";
//    anim.duration = 2;
//    [self.heart.layer addAnimation:anim forKey:nil];
    
}

- (void)keyframeAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 300, 400)];
    
    anim.path = path.CGPath;
    // anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    
    [self.heart.layer addAnimation:anim forKey:nil];
}

- (void)shakeAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Rad(-5)),@(angle2Rad(5)),@(angle2Rad(-5))];
    anim.keyTimes = @[@(0.1),@(0.9),@(0.1)];
    anim.repeatCount = MAXFLOAT;
    [self.heart.layer addAnimation:anim forKey:nil];
}

- (void)heartAnimation
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.toValue = @(0.5);
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    [self.heart.layer addAnimation:anim forKey:nil];
}

- (void)groupAnimation
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    
    CABasicAnimation *animTwo = [CABasicAnimation animation];
    animTwo.keyPath = @"position";
    animTwo.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    
    group.animations = @[anim,animTwo];
    group.repeatCount = MAXFLOAT;
    group.duration = 2;
    group.autoreverses = YES;
    
    [self.image.layer addAnimation:group forKey:nil];
}

- (void)basicAnimation
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    //anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    anim.toValue = @(angle2Rad(45));
    anim.repeatCount = MAXFLOAT;
    anim.duration = 2;
    anim.autoreverses = YES;
    [self.image.layer addAnimation:anim forKey:nil];
    
    
    CABasicAnimation *animTwo = [CABasicAnimation animation];
    
    animTwo.keyPath = @"position";
    animTwo.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    animTwo.repeatCount = MAXFLOAT;
    animTwo.duration = 2;
    animTwo.autoreverses = YES;
    [self.image.layer addAnimation:animTwo forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
