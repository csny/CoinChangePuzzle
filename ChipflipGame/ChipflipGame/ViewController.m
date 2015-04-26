//
//  ViewController.m
//  ChipflipGame
//
//  Created by macbook on 2015/04/20.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addViews
{
    // DrawingViewクラスのインスタンス化
    DrawingView *drawView = [[DrawingView alloc] initWithFrame:self.view.bounds];
    drawView.tag = 73186;
    
    // ラベルを作成
    UILabel *explainLabel1 = [[UILabel alloc] init];
    explainLabel1.tag = 73187;
    explainLabel1.frame = CGRectMake(30, 420, 300, 30);
    explainLabel1.backgroundColor = [UIColor clearColor];
    explainLabel1.textColor = [UIColor whiteColor];
    explainLabel1.font = [UIFont fontWithName:@"AvenirNext-Italic" size:16];
    explainLabel1.textAlignment = NSTextAlignmentLeft;
    explainLabel1.text = @"By swiping, Replace yellow and white";
    UILabel *explainLabel2 = [[UILabel alloc] init];
    explainLabel2.tag = 73188;
    explainLabel2.frame = CGRectMake(20, 450, 300, 30);
    explainLabel2.backgroundColor = [UIColor clearColor];
    explainLabel2.textColor = [UIColor whiteColor];
    explainLabel2.font = [UIFont fontWithName:@"AvenirNext-Italic" size:16];
    explainLabel2.textAlignment = NSTextAlignmentLeft;
    explainLabel2.text = @"chips directly connected with a line.";
    UILabel *explainLabel3 = [[UILabel alloc] init];
    explainLabel3.tag = 73189;
    explainLabel3.frame = CGRectMake(30, 480, 300, 30);
    explainLabel3.backgroundColor = [UIColor clearColor];
    explainLabel3.textColor = [UIColor whiteColor];
    explainLabel3.font = [UIFont fontWithName:@"AvenirNext-Italic" size:16];
    explainLabel3.textAlignment = NSTextAlignmentLeft;
    explainLabel3.text = @"Then make bellow figure.";
    // 画像
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 505, 250, 140)];
    // 画像の読み込み
    imageView.image = [UIImage imageNamed:@"complete.png"];
    imageView.tag = 73190;
    // ボタンを作成
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetBtn.tag = 73191;
    resetBtn.center = CGPointMake(170, 380);
    [resetBtn setBackgroundColor:[UIColor whiteColor]];
    [resetBtn.layer setShadowOpacity:1.0f];
    [resetBtn setTitle:@"Reset"
              forState:UIControlStateNormal];
    [resetBtn sizeToFit];
    [resetBtn addTarget:self
                 action:@selector(button_Tapped:)
       forControlEvents:UIControlEventTouchUpInside];
    
    // UIView、ラベル、ボタンをビューに追加
    [self.view addSubview:drawView];
    [self.view addSubview:explainLabel1];
    [self.view addSubview:explainLabel2];
    [self.view addSubview:explainLabel3];
    [self.view addSubview:imageView];
    [self.view addSubview:resetBtn];
}

// リセットボタン
- (void)button_Tapped:(id)sender
{
    // ビュー削除
    UIView *beforeView1 = [self.view viewWithTag:73186];
    UIView *beforeView2 = [self.view viewWithTag:73187];
    UIView *beforeView3 = [self.view viewWithTag:73188];
    UIView *beforeView4 = [self.view viewWithTag:73189];
    UIView *beforeView5 = [self.view viewWithTag:73190];
    UIView *beforeView6 = [self.view viewWithTag:73191];
    /*
    // 実装順を覚えてればこれでも可
    UIView *beforeView1 = [self.view.subviews objectAtIndex:0];
    UIView *beforeView2 = [self.view.subviews objectAtIndex:1];
    UIView *beforeView3 = [self.view.subviews objectAtIndex:2];
    UIView *beforeView4 = [self.view.subviews objectAtIndex:3];
    */
    
    [beforeView1 removeFromSuperview];
    [beforeView2 removeFromSuperview];
    [beforeView3 removeFromSuperview];
    [beforeView4 removeFromSuperview];
    [beforeView5 removeFromSuperview];
    [beforeView6 removeFromSuperview];
    // 再作成
    [self addViews];
}


@end
