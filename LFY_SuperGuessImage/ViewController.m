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
#define kAnswerBtnTitleColor [UIColor blackColor]

CGFloat const kMarginBetweenBtns = 10;
NSInteger const kOptionViewTotalCol = 7;

CGFloat const kBtnW = 35;
CGFloat const kBtnH = 35;

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
    
    
    self.index = -1;
    [self nextBtnOnClick];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipBtnOnClick:(id)sender {
}
- (IBAction)helpBtnOnclick:(id)sender {
#warning noCode
}

- (void)answerBtnOnClick:(id)sender {
    
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
            NSLog(@"guessBtn.frame1 = %@",NSStringFromCGRect(self.guessBtn.frame));

            self.guessBtn.transform = CGAffineTransformMakeScale(scaleX, scaleX);
            //遮盖显现
            NSLog(@"guessBtn.frame2 = %@",NSStringFromCGRect(self.guessBtn.frame));
            
      

            self.guessBtn.transform = CGAffineTransformTranslate(self.guessBtn.transform, 0, translateY);
            NSLog(@"guessBtn.frame3 = %@",NSStringFromCGRect(self.guessBtn.frame));

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
- (IBAction)nextBtnOnClick {
    self.index ++;
    if(self.index >= self.questions.count){
        NSLog(@"恭喜通关");
        self.index --;
        return;
    }
    

      // 2.取出模型
    QuestionInfo *question = self.questions[self.index];
        // 3.设计基本信息(参考图片浏览器)
    [self setupBaseInfo:question];
    
    
    // 4.创建答案按钮
    [self createAnswerBtns:question];
    
    // 5.创建备选答案按钮
    [self createOptionBtns:question];



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


#pragma mark - Pravet Method
- (void)setupBaseInfo:(QuestionInfo *)question{
    // 顶部图片索引改变
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.questions.count];
    // 图片种类描述改变
    self.descLabel.text = question.title;
    // 图片改变
    [self.guessBtn setImage:question.image forState:UIControlStateNormal];
    // 下一题按钮状态判断改变
    self.nextBtn.enabled = (self.index != self.questions.count - 1);
}

- (void)createAnswerBtns:(QuestionInfo *)question{
    //1 清空anAnswerView
    for(UIButton *btn  in [self.answerView subviews]){
        [btn removeFromSuperview];
    }
    //2 获取答案的数量
    NSInteger answerBtnCount = question.answer.length;
    CGFloat answerW = self.answerView.bounds.size.width;
    CGFloat answerEdgeInset = (answerW - answerBtnCount * kBtnW - (answerBtnCount - 1) * kMarginBetweenBtns) * 0.5;

    for(int i=0;i<answerBtnCount;i++){
        UIButton *btn = [UIButton new];
        CGFloat btnX = answerEdgeInset + i * (kBtnW + kMarginBetweenBtns);

        btn.frame = CGRectMake(btnX, 10, kBtnW, kBtnH);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitleColor:kAnswerBtnTitleColor forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(answerBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.answerView addSubview:btn];
    }
}

- (void)createOptionBtns:(QuestionInfo *)question{
    int optionsCount = question.options.count;
    
    if (self.optionsView.subviews.count != optionsCount) {
        // 若没按钮,就创建按钮
        CGFloat optionW = self.optionsView.bounds.size.width;
        CGFloat optionEdgeInset = (optionW - kOptionViewTotalCol * kBtnW - (kOptionViewTotalCol - 1) * kMarginBetweenBtns) * 0.5;
        
        for (int i = 0; i < optionsCount; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            int col = i % kOptionViewTotalCol;
            int row = i / kOptionViewTotalCol;
            
            CGFloat btnX = optionEdgeInset + (kBtnW + kMarginBetweenBtns) * col;
            CGFloat btnY = kMarginBetweenBtns + (kBtnH + kMarginBetweenBtns) * row;
            btn.frame = CGRectMake(btnX, btnY, kBtnW, kBtnH);
            
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
            [btn setTitleColor:kAnswerBtnTitleColor forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(opitonBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.optionsView addSubview:btn];
        }
    }
    
    for (int i = 0; i < optionsCount; i++) {
        UIButton *optionBtn = self.optionsView.subviews[i];
        [optionBtn setTitle:question.options[i] forState:UIControlStateNormal];
        optionBtn.hidden = NO;
    }
}


/**
 *  备选答案按钮点击方法
 *
 *  @param optionBtn
 */
- (void)opitonBtnOnClick:(UIButton *)optionBtn
{
    NSString *optionStr = optionBtn.currentTitle;
    // 1.填字进answerView
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (nil == answerBtn.currentTitle) {
            [answerBtn setTitle:optionStr forState:UIControlStateNormal];
            break;
        }
    }

    // 2.隐藏按钮
    optionBtn.hidden = YES;

    // 3.当answerView中字满的时候
    BOOL isFull = YES;
//
    NSMutableString *strM = [NSMutableString string];
//    for (UIButton *answerBtn in self.answerView.subviews) {
//        if (nil == answerBtn.currentTitle) {
//            isFull = NO;
//            break;
//        }
//        else
//        {
//            // ->3.1将答案区按钮中字拼成一个字符串，
//            [strM appendString:answerBtn.currentTitle];
//        }
//    }
//    
//    if (YES == isFull) {
//        self.optionsVIew.userInteractionEnabled = NO;
//        
//        NSString *answer = [self.questions[self.index] answer];
//        if ([strM isEqualToString:answer]) {
//            for (UIButton *answerBtn in self.answerView.subviews) {
//                // ->3.3相同 全部字体变蓝，加分，1秒后自动进入下一题
//                [answerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//            }
//            
//            [self coinChange:kTrueAddScore];
//            
//            
//            
//            [self performSelector:@selector(nextBtnOnClick) withObject:nil afterDelay:1.0];
//        }else
//        {
//            // ->3.2与答案比较，不同 全部字体变红，扣分
//            for (UIButton *answerBtn in self.answerView.subviews) {
//                [answerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                
//                [self coinChange:kFalseDecreaseScore];
//                
//            }
//        }
//    }
}


@end
