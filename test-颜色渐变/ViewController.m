//
//  ViewController.m
//  test-颜色渐变
//
//  Created by qujiahong on 2017/10/25.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "ViewController.h"
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ViewController ()

@property (nonatomic, strong) NSArray *leftColor;
@property (nonatomic, strong) NSArray *rightColor;
@property (nonatomic, weak) UILabel * leftLabel;
@property (nonatomic, weak) UILabel * rightLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * leftColor = @[@85, @85, @85];
    _leftColor = leftColor;
    NSArray * rightColor = @[@255, @128, @0];
    _rightColor = rightColor;
    
    [self createLeftLabel];
    [self createRightLabel];
    
    [self createSlider];
    
}

-(void)createLeftLabel{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(100, 64, 50, 40);
    leftLabel.text = @"一";
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.backgroundColor = RGBColor([self.leftColor[0] floatValue], [self.leftColor[1] floatValue], [self.leftColor[2] floatValue]);

    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    _leftLabel = leftLabel;
}

- (void)createRightLabel{
    UILabel * rightLabel = [[UILabel alloc]init];
    rightLabel.frame = CGRectMake(250, 64, 50, 40);
    rightLabel.text = @"二";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.backgroundColor = RGBColor([self.rightColor[0] floatValue], [self.rightColor[1] floatValue], [self.rightColor[2] floatValue]);

    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    _rightLabel = rightLabel;
}

-(void)createSlider{
    UISlider *moveSlider = [[UISlider alloc]initWithFrame:CGRectMake(100, 150, 200, 5)];
    moveSlider.minimumValue = 0;
    moveSlider.maximumValue = 1;
    moveSlider.minimumTrackTintColor = [UIColor redColor];
    moveSlider.maximumTrackTintColor = [UIColor blueColor];
    [moveSlider addTarget:self action:@selector(drag:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:moveSlider];
}
-(void)drag:(UISlider *)slider{
    
    CGFloat r = [self.rightColor[0] floatValue]-[self.leftColor[0] floatValue];
    CGFloat g = [self.rightColor[1] floatValue]-[self.leftColor[1] floatValue];
    CGFloat b = [self.rightColor[2] floatValue]-[self.leftColor[2] floatValue];
    
    //取出颜色变化的范围
    NSArray * colorRange = [NSArray arrayWithObjects:[self CGFloatChangeToNSString:g], [self CGFloatChangeToNSString:r], [self CGFloatChangeToNSString:b],nil];
    //变化left
    CGFloat rr = [self.rightColor[0] floatValue]-[colorRange[0] floatValue]*slider.value;
    CGFloat gg = [self.rightColor[1] floatValue]-[colorRange[1] floatValue]*slider.value;
    CGFloat bb = [self.rightColor[2] floatValue]-[colorRange[2] floatValue]*slider.value;
    self.leftLabel.backgroundColor = RGBColor(rr, gg, bb);
    //变化right
    CGFloat rrr = [self.leftColor[0] floatValue]+[colorRange[0] floatValue]*slider.value;
    CGFloat ggg = [self.leftColor[1] floatValue]+[colorRange[1] floatValue]*slider.value;
    CGFloat bbb = [self.leftColor[2] floatValue]+[colorRange[2] floatValue]*slider.value;
    self.rightLabel.backgroundColor = RGBColor(rrr, ggg, bbb);
    
    
    //假判断(因为这里的slider.value并不是一个好的因数)[应该用距离.x才对，这里为了方便]
    if (slider.value==slider.maximumValue) {
        _leftLabel.backgroundColor = RGBColor([self.rightColor[0] floatValue], [self.rightColor[1] floatValue], [self.rightColor[2] floatValue]);
        _rightLabel.backgroundColor = RGBColor([self.leftColor[0] floatValue], [self.leftColor[1] floatValue], [self.leftColor[2] floatValue]);
    }
}

-(NSString *)CGFloatChangeToNSString:(CGFloat)f{
    NSString * str = [NSString stringWithFormat:@"%f",f];
    return str;
}

@end
