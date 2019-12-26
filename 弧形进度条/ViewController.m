//
//  ViewController.m
//  弧形进度条
//
//  Created by clare on 19/12/25.
//  Copyright © 2019年 zhou. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
@interface ViewController ()
@property(nonatomic,strong)HuView *huView;
@property(nonatomic,strong)HuView *huView2;
@property(nonatomic,strong)HuView *huView3;
@property(nonatomic,strong)HuView *huView4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
          for(int index = 0; index < 4; index++) {
              
                  CGFloat margin_X = 50; // 水平间距
                     
                     CGFloat _margin_Y = 50; // 数值间距
                     
                     CGFloat itemWidth = 100; // 宽
                     
                     CGFloat itemHeight = 100; // 高
                     
                     int totalColumns = 1; // 每行最大列数（影响到底几个换行）
              int row = index / totalColumns;
              int col = index % totalColumns;
              CGFloat cellX =  50 +col * (itemWidth + margin_X);
              CGFloat cellY = 50 + row * (itemHeight + _margin_Y);
             HuView *huView = [[HuView alloc]initWithFrame:CGRectMake(cellX,cellY, itemWidth, itemHeight)];
               huView.backgroundColor = [UIColor lightGrayColor];
               [self.view addSubview:_huView];
               huView.backgroundColor = [UIColor greenColor];
               huView.numDown = 10;
//              // 此时为扇形
//               huView.lineWidth = huView.frame.size.height/2;
            huView.lineWidth = 20;
              switch (index) {
                  case 0:
                       huView.circleType = circleTypeCWAdd;
                      break;
                      case 1:
                    huView.circleType = circleTypeCWDown;
                      break;
                      case 2:
                    huView.circleType = circleTypeCWWAdd;
                     break;
                      case 3:
                    huView.circleType = circleTypeCWWDown;
                    break;

                  default:
                      break;
              }
              
              
              [self.view addSubview:huView];
          }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
