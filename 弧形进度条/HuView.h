//
//  HuView.h
//  弧形进度条
//
//  Created by clare on 19/12/25.
//  Copyright © 2019年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
typedef NS_ENUM(NSInteger,CircleType) {
    //顺时针增加
    circleTypeCWAdd = 0,
    //顺时针减少
    circleTypeCWDown ,
    //逆时针增加
    circleTypeCWWAdd ,
    //逆时针减少
    circleTypeCWWDown
};
@interface HuView : UIView


@property(nonatomic,assign)int numDown;
@property(nonatomic,assign)int num;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)CircleType circleType;
@property (nonatomic,assign)CGFloat lineWidth;

@property(assign,nonatomic)CGFloat progress;
@property(assign,nonatomic)CGFloat startAngle;

@property(assign,nonatomic)CGFloat endAngle;
@end
