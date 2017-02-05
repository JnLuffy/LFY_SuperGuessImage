//
//  ViewController.m
//  LFY_SuperGuessImage
//
//  Created by IOS.Mac on 17/2/4.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "ViewController.h"
#import "QuestionInfo.h"

CGFloat const imageW = 150;
#define kScreenW [UIScreen mainScreen].bounds.size.width

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


/**
 大图/遮盖/中间 3个按钮的点击事件

 @param sender <#sender description#>
 */
- (IBAction)imgBtnChangeOnClick:(id)sender {
    //将中间图片按钮设置成距离屏幕最近的一层
    [self.view bringSubviewToFront:self.guessBtn];
    //
    if(0 == self.cover.alpha) {
        //图片放大事件
        CGFloat scaleX = kScreenW/imageW;
        CGFloat translateY = self.guessBtn.frame.origin.y / scaleX;

        [UIView animateWithDuration:1.0 animations:^{
            self.guessBtn.transform = CGAffineTransformMakeScale(scaleX, scaleX);
            //遮盖显现
            self.guessBtn.transform = CGAffineTransformTranslate(self.guessBtn.transform, 0, translateY);
            self.cover.alpha = 0.5;
        }];
    } else{
        //图片还原事件
        [UIView animateWithDuration:1.0 animations:^{
            self.guessBtn.transform = CGAffineTransformIdentity;
            self.cover.alpha = 0.0;
        }];
    }
}
- (IBAction)nextBtnOnClick:(id)sender {
}

/**
 * 懒加载
 * @return 模型数组
 */
-(NSArray *)questions{
    if(!_questions){
        _questions = [QuestionInfo questions];
    }
    return _questions;
}


/**
  懒加载

 @return 遮盖
 */
- (UIButton *)cover{
    if(!_cover){
        _cover = [[UIButton alloc]init];
        _cover.frame = self.view.bounds;
        _cover.alpha = 0.0;
        _cover.backgroundColor = [UIColor blackColor];
        [_cover addTarget:self action:@selector(imgBtnChangeOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cover];
    }
    return _cover;
}
@end
