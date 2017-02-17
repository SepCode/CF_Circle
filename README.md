# CF_Circle
iOS多彩旋转圆环
>最近在写项目时，需要一个加载动画，看了一下网上没有类似的demo，在这里给大家分享一下，先上效果图：

![circle.gif](http://upload-images.jianshu.io/upload_images/1907722-578a6b8efa8f0f0a.gif?imageMogr2/auto-orient/strip)

```objc
    //采用贝瑟尔路径绘制圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.heart.frame.size.width * 0.5, self.heart.frame.size.width * 0.5) radius:self.heart.frame.size.width * 0.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.repeatCount = MAXFLOAT;
    // 设置layer的animation
    [shapeLayer addAnimation:animation forKey:nil];

    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(angle2Rad(360));
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    

    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim2.keyPath = @"strokeColor";
    NSValue *v1 = (id)[UIColor blueColor].CGColor;
    NSValue *v2 = (id)[UIColor redColor].CGColor;
    NSValue *v3 = (id)[UIColor greenColor].CGColor;
    anim2.values = @[v1,v2,v3];
    anim2.duration = 3;
    anim2.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anim2 forKey:nil];
    
    // self.heart需要添加动画的view
    [self.heart.layer addSublayer:shapeLayer];
    [self.heart.layer addAnimation:anim forKey:nil];

```

##动画的实现分为以下几步
- CAShapeLayer绘制圆环
>CAShapeLayer就不说了，在简书都有很多介绍它的文章，对它不了解的同学可以搜索看一看。

  ```objc
 //采用贝瑟尔路径绘制圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.heart.frame.size.width * 0.5, self.heart.frame.size.width * 0.5) radius:self.heart.frame.size.width * 0.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];

    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
```
- 添加圆环进度动画
    >CAShapeLayer的`strokeStart`和`strokeEnd`属性可以设置一条Path的起始和终止的位置，通过利用`strokeStart`和`strokeEnd`这两个属性支持动画的特点，可以实现圆形进度条的效果。
这个动画中很有意思的一点也就是`autoreverses `**自动反转**的效果了，其它的属性就不说了。

  ```objc

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.repeatCount = MAXFLOAT;
    // 设置layer的animation
    [shapeLayer addAnimation:animation forKey:nil];
```
- 添加旋转动画
  >旋转动画在这里的效果其实就是为了产生一些视觉错觉，这里用到了一个宏定义，角度转弧度：

  ```objc
#define angle2Rad(angle) (angle / 180.0 * M_PI)
```

  ```objc
CABasicAnimation *anim = [CABasicAnimation animation];

    anim.keyPath = @"transform.rotation";
    anim.toValue = @(angle2Rad(360));
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
```
- 添加颜色过度动画
  >之前看到一些采用渐变CAGradientLayer写的圆环，但不是想要的效果，所以这里我们没有采用，我们使用帧动画实现变色，虽然官方给出的keypath就那么多，但是根据KVC的编程思想，有些时候我们想要实现什么效果不试试还是不行的，比如这个`strokeColor `

  ```objc
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];

    // 设置动画属性
    anim2.keyPath = @"strokeColor";
    NSValue *v1 = (id)[UIColor blueColor].CGColor;
    NSValue *v2 = (id)[UIColor redColor].CGColor;
    NSValue *v3 = (id)[UIColor greenColor].CGColor;
    anim2.values = @[v1,v2,v3];
    anim2.duration = 3;
    anim2.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:anim2 forKey:nil];
```


我想在这里留个纪念定下自己的座右铭—————— Becoming a Better Programmer
