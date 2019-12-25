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
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {4,0};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor whiteColor] set];
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
    CGFloat length[] = {4,0};
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

@end
