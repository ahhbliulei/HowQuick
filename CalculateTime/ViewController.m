//
//  ViewController.m
//  CalculateTime
//
//  Created by 蔡强 on 2017/8/24.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *textField;


@property (weak) IBOutlet NSTextField *label;

@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,assign) float hundredthSecond;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    _hundredthSecond = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _hundredthSecond ++;
        //NSLog(@"开始了%f", hundredthSecond);
        
        self.label.stringValue = [NSString stringWithFormat:@"已耗时:%.2f秒", _hundredthSecond / 100];
    }];
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    //NSLog(@"controlTextDidChange: stringValue == %@", [textField stringValue]);
    
    NSString *str = textField.stringValue.lowercaseString;
    
    // 输入“a”开始计时
    if (str.length > 0 && [[str substringFromIndex:str.length-1] isEqualToString:@"a"]) {
        _hundredthSecond = 0;
        
        // 开启timer
        self.timer.fireDate = [NSDate distantPast];
    }
    
    // 输入“z”结束计时
    if (str.length > 0 && [[str substringFromIndex:str.length-1] isEqualToString:@"z"]) {
        
        // 结束timer
        self.timer.fireDate = [NSDate distantFuture];
        
        
        // 后26个字母正确则完成
        if (str.length >= 26 && [[[str lowercaseString] substringFromIndex:str.length - 26] isEqualToString:@"abcdefghijklmnopqrstuvwxyz"]) {
            
        }else {
            NSLog(@"未正确输入26个字母");
            self.label.stringValue = [NSString stringWithFormat:@"未正确输入26个字母(耗时：%.2f)", _hundredthSecond / 100];
        }
        
        _hundredthSecond = 0;
    }
   
}

@end
