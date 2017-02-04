//
//  ViewController.m
//  LFY_SuperGuessImage
//
//  Created by IOS.Mac on 17/2/4.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/**
 *   顶部索引
 */
@property (weak, nonatomic) IBOutlet UILabel *topIndexLabel;
/**
 *   注释
 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/**
 *   注释
 */
@property (weak, nonatomic) IBOutlet UIButton *guessBtn;
/**
 *   <##>
 */
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

/**
 *   模型数组
 */
@property (nonatomic,strong)NSArray *questions;
/**
 *   索引
 */
@property (nonatomic,assign) int index;

/**
 *   遮盖
 */
@property (nonatomic,strong) UIButton *cover;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _guessBtn.imageEdgeInsets =  UIEdgeInsetsMake(4, 4, 4, 4);
    [_helpBtn setBackgroundImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [_helpBtn setBackgroundImage:[UIImage imageNamed:@"btn_left_highlighted"] forState:UIControlStateHighlighted];
    
    [_helpBtn setTitle:@"哈哈" forState:UIControlStateNormal];
    _helpBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [_helpBtn setImage:[UIImage imageNamed:@"icon_help"] forState:UIControlStateNormal];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipBtnOnClick:(id)sender {
}
- (IBAction)helpBtnOnclick:(id)sender {
}
- (IBAction)imgBtnChangeOnClick:(id)sender {
    NSLog(@"imgBtnChangeOnClick");
}
- (IBAction)nextBtnOnClick:(id)sender {
}

@end
