//
//  HuView.m
//  弧形进度条
//
//  Created by clare on 19/12/25.
//  Copyright © 2019年 zhou. All rights reserved.
//

#import "HuView.h"
@implementation HuView
- (void)drawRect:(CGRect)rect {
    //    仪表盘底部
    [self drawHu1];
    //    仪表盘进度
    [self drawHu2];
}
-(void)drawHu2
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, _lineWidth);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线为负值则h不会看到交替现象
    CGFloat length[] = {4,- 0.001};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor orangeColor] set];
    CGFloat end;
    switch (_circleType) {
        case circleTypeCWAdd:
            end = -M_PI_2 + M_PI * 2 *_num/_numDown ;
             CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, (self.frame.size.height - _lineWidth )/2, -M_PI_2, end , 0);
            break;

           case circleTypeCWDown:
            end = -M_PI_2 + M_PI * 2 *_num/_numDown ;
            CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, (self.frame.size.height - _lineWidth )/2, -M_PI_2, end , 1);
             break;
            case circleTypeCWWDown:
             end = -M_PI_2 - M_PI * 2 *_num/_numDown ;
             CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, (self.frame.size.height - _lineWidth )/2, -M_PI_2, end , 0);
             break;
            case circleTypeCWWAdd:
            end = -M_PI_2 - M_PI * 2 *_num/_numDown ;
            CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, (self.frame.size.height - _lineWidth)/2, -M_PI_2, end , 1);
             break;
        default:
            break;
    }
    //3.绘制
    CGContextStrokePath(ctx);
}
- (void) drawHu1
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, _lineWidth);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {4,- 0.001};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor blackColor] set];
    //2.设置路径
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2   , (self.frame.size.height - _lineWidth )/2, 0, M_PI * 2, 0);
    //3.绘制
    CGContextStrokePath(ctx);
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numDown = 100;
        _num = 0;
        _lineWidth = 10;
        _numLabel = [[UILabel alloc]init];
        _numLabel.textAlignment  = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.font = [UIFont systemFontOfSize:self.frame.size.width/2];
        _numLabel.center = self.center;
        [_numLabel sizeToFit];
        _numLabel.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
       
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
        }
        
        [self addSubview:_numLabel];
        
    }
    return self;
}
-(void)change
{
    _num +=1;
    if (_num > _numDown) {
           _num = 0;
       }
     
    _numLabel.text = [NSString stringWithFormat:@"%d",_num];
     [self setNeedsDisplay];
   
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}
-(void)stopTimer{
       [[NSNotificationCenter defaultCenter] removeObserver:self];
       [self.timer invalidate];
       self.timer = nil;
}

//
//- (void)drawShan{
//   
//    //    定义扇形中心
//          CGPoint origin = CGPointMake(self.center.x, self.center.y);
//      //    定义扇形半径
//          CGFloat radius = 100.0f;
//          
//      //    设定扇形起点位置
//          CGFloat startAngle = - M_PI_2;
//      //    根据进度计算扇形结束位置
//          CGFloat endAngle = startAngle + 1.0 *_num/_numDown * M_PI * 2;
//          
//      //    根据起始点、原点、半径绘制弧线
//          UIBezierPath *sectorPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
//          
//      //    从弧线结束为止绘制一条线段到圆心。这样系统会自动闭合图形，绘制一条从圆心到弧线起点的线段。
//          [sectorPath addLineToPoint:origin];
//          
//      //    设置扇形的填充颜色
//          [[UIColor darkGrayColor] set];
//          
//      //    设置扇形的填充模式
//          [sectorPath fill];
//}
//
//
//- (void)ballShow{
//    CGPoint origin = CGPointMake(self.center.x, self.center.y);
//         CGFloat radius = self.frame.size.width/2;
//         
//         UIBezierPath *ballPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
//         
//         [[UIColor purpleColor]set];
//         [ballPath fill];
//         
//     //    在球形的外面绘制一个描边空心的圆形，不然很难看
//         UIBezierPath *strokePath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:0 endAngle:-0.00000001 clockwise:YES];
//         [[UIColor orangeColor]set];
//         [strokePath stroke];
//    
//         //    设置起始点，位置是根据进度动态变换的放到定时器方法中，这里先放到这里，实际开发h中要放到定时器的方法中
//          self.startAngle = M_PI_2 - 1.0 *_num/_numDown * M_PI;
//          self.endAngle = M_PI_2 + 1.0 *_num/_numDown * M_PI;
//       
//}
//



@end
