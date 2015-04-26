//
//  DrawingView.m
//  CoinChangePuzzle
//
//  Created by macbook on 2015/04/26.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initDrawArrays];
    }
    
    return self;
}

- (void)initDrawArrays
{
    // コイン総数
    _BEGIN_CHIP_NUM=12;
    
    // コインの初期位置
    _chipLocation = [@[@"G",@"F",@"E",@"I",@"B",@"H",@"J",@"A",@"D",@"C",@"L",@"K"] mutableCopy];
    
    // 各種変数の初期化
    _isSelected=NO;
    _cnt=0;
    _selectedChip=10001;
    _nextChips = [@[@10001,@10001,@10001] mutableCopy];
    _stateMessage=@"Drag and drop";
    
    // チップの隣接関係
    _adjacency = @[@[@6,@9,@10001],
                   @[@7,@8,@10],
                   @[@4,@9,@11],
                   @[@5,@10,@10001],
                   @[@2,@10,@10001],
                   @[@3,@11,@10001],
                   @[@0,@8,@10001],
                   @[@1,@9,@10001],
                   @[@1,@6,@10001],
                   @[@0,@2,@7],
                   @[@1,@3,@4],
                   @[@2,@5,@10001]];
    
    
    // 円の中心座標を配列へ格納
    NSValue *val0,*val1,*val2,*val3,*val4,*val5,*val6,*val7,*val8,*val9,*val10,*val11;
    val0 = [NSValue valueWithCGPoint:CGPointMake(50,80)];
    val1 = [NSValue valueWithCGPoint:CGPointMake(140,80)];
    val2 = [NSValue valueWithCGPoint:CGPointMake(230,80)];
    val3 = [NSValue valueWithCGPoint:CGPointMake(320,80)];
    val4 = [NSValue valueWithCGPoint:CGPointMake(50,180)];
    val5 = [NSValue valueWithCGPoint:CGPointMake(140,180)];
    val6 = [NSValue valueWithCGPoint:CGPointMake(230,180)];
    val7 = [NSValue valueWithCGPoint:CGPointMake(320,180)];
    val8 = [NSValue valueWithCGPoint:CGPointMake(50,280)];
    val9 = [NSValue valueWithCGPoint:CGPointMake(140,280)];
    val10 = [NSValue valueWithCGPoint:CGPointMake(230,280)];
    val11 = [NSValue valueWithCGPoint:CGPointMake(320,280)];
    _circlePtArr = @[val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11];
    
    // 円描画情報を配列へ格納
    float R = 60.0; // 直径
    NSValue *cirval0,*cirval1,*cirval2,*cirval3,*cirval4,*cirval5,*cirval6,*cirval7,*cirval8,*cirval9,*cirval10,*cirval11;
    cirval0 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:0] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:0] CGPointValue].y-R/2, R, R)];
    cirval1 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:1] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:1] CGPointValue].y-R/2, R, R)];
    cirval2 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:2] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:2] CGPointValue].y-R/2, R, R)];
    cirval3 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:3] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:3] CGPointValue].y-R/2, R, R)];
    cirval4 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:4] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:4] CGPointValue].y-R/2, R, R)];
    cirval5 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:5] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:5] CGPointValue].y-R/2, R, R)];
    cirval6 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:6] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:6] CGPointValue].y-R/2, R, R)];
    cirval7 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:7] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:7] CGPointValue].y-R/2, R, R)];
    cirval8 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:8] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:8] CGPointValue].y-R/2, R, R)];
    cirval9 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:9] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:9] CGPointValue].y-R/2, R, R)];
    cirval10 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:10] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:10] CGPointValue].y-R/2, R, R)];
    cirval11 = [NSValue valueWithCGRect:CGRectMake([[_circlePtArr objectAtIndex:11] CGPointValue].x-R/2, [[_circlePtArr objectAtIndex:11] CGPointValue].y-R/2, R, R)];
    _circleRectArr = @[cirval0,cirval1,cirval2,cirval3,cirval4,cirval5,cirval6,cirval7,cirval8,cirval9,cirval10,cirval11];
}

- (void)drawRect:(CGRect)rect
{
    // 描画管理の構造体contextを初期化
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 色を定義
    CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
    CGFloat emerald[4] = {0.0f, 0.8f, 0.7f, 1.0f};
    CGFloat gray[4] = {0.8f, 0.8f, 0.8f, 1.0f};
    CGFloat orange[4] = {1.0f, 0.5f, 0.0f, 1.0f};
    CGFloat yellow[4] = {1.0f, 1.0f, 0.0f, 1.0f};
    
    // 隣接関係の接続線を描画
    CGContextSetStrokeColor(context, gray);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0f);
    
    // 羅列
    // 一段目
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:0] CGPointValue].x, [[_circlePtArr objectAtIndex:0] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:9] CGPointValue].x, [[_circlePtArr objectAtIndex:9] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:0] CGPointValue].x, [[_circlePtArr objectAtIndex:0] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:6] CGPointValue].x, [[_circlePtArr objectAtIndex:6] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:1] CGPointValue].x, [[_circlePtArr objectAtIndex:1] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:8] CGPointValue].x, [[_circlePtArr objectAtIndex:8] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:1] CGPointValue].x, [[_circlePtArr objectAtIndex:1] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:10] CGPointValue].x, [[_circlePtArr objectAtIndex:10] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:1] CGPointValue].x, [[_circlePtArr objectAtIndex:1] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:7] CGPointValue].x, [[_circlePtArr objectAtIndex:7] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:2] CGPointValue].x, [[_circlePtArr objectAtIndex:2] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:4] CGPointValue].x, [[_circlePtArr objectAtIndex:4] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:2] CGPointValue].x, [[_circlePtArr objectAtIndex:2] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:9] CGPointValue].x, [[_circlePtArr objectAtIndex:9] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:2] CGPointValue].x, [[_circlePtArr objectAtIndex:2] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:11] CGPointValue].x, [[_circlePtArr objectAtIndex:11] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:3] CGPointValue].x, [[_circlePtArr objectAtIndex:3] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:5] CGPointValue].x, [[_circlePtArr objectAtIndex:5] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:3] CGPointValue].x, [[_circlePtArr objectAtIndex:3] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:10] CGPointValue].x, [[_circlePtArr objectAtIndex:10] CGPointValue].y);
    // 二段目
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:4] CGPointValue].x, [[_circlePtArr objectAtIndex:4] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:10] CGPointValue].x, [[_circlePtArr objectAtIndex:10] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:5] CGPointValue].x, [[_circlePtArr objectAtIndex:5] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:11] CGPointValue].x, [[_circlePtArr objectAtIndex:11] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:6] CGPointValue].x, [[_circlePtArr objectAtIndex:6] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:8] CGPointValue].x, [[_circlePtArr objectAtIndex:8] CGPointValue].y);
    CGContextMoveToPoint(context, [[_circlePtArr objectAtIndex:7] CGPointValue].x, [[_circlePtArr objectAtIndex:7] CGPointValue].y);
    CGContextAddLineToPoint(context, [[_circlePtArr objectAtIndex:9] CGPointValue].x, [[_circlePtArr objectAtIndex:9] CGPointValue].y);
    
    CGContextStrokePath(context);
    
    // フラグに応じて円を描画
    for(int i=0;i<_BEGIN_CHIP_NUM;i++){
        NSValue *tempRect = [_circleRectArr objectAtIndex:i];
        if ([self judgeChipcolor:_chipLocation[i]]) {
            CGContextSetFillColor(context, yellow);
            CGContextFillEllipseInRect(context, [tempRect CGRectValue]);
        } else {
            CGContextSetFillColor(context, white);
            CGContextFillEllipseInRect(context, [tempRect CGRectValue]);
        }
        // チップが選択された場合の特別描画
        if (_isSelected) {
            // コイン１枚目
            if (i==_selectedChip) {
                CGContextSetStrokeColor(context, orange);
                CGContextSetLineWidth(context, 5.0);
                CGContextStrokeEllipseInRect(context, [tempRect CGRectValue]);
            }
            for (int j=0; j<3; j++) {
                // 交換可能なコイン
                if (i==[_nextChips[j] intValue]) {
                    CGContextSetStrokeColor(context, emerald);
                    CGContextSetLineWidth(context, 5.0);
                    CGContextStrokeEllipseInRect(context, [tempRect CGRectValue]);
                }
            }
        }
    }
    
    // 成功判定
    if ([_chipLocation[0] isEqual:@"A"] &&  [_chipLocation[1] isEqual:@"B"] && [_chipLocation[2] isEqual:@"C"] && [_chipLocation[3] isEqual:@"D"] && [_chipLocation[4] isEqual:@"E"] && [_chipLocation[5] isEqual:@"F"] && [_chipLocation[6] isEqual:@"G"] && [_chipLocation[7] isEqual:@"H"] && [_chipLocation[8] isEqual:@"I"] && [_chipLocation[9] isEqual:@"J"] && [_chipLocation[10] isEqual:@"K"] && [_chipLocation[11] isEqual:@"L"]) {
        _stateMessage=@"Congratulation!";
    }
    
    // チップの名前表示
    UIFont *chipFont = [UIFont fontWithName:@"ArialMT" size:40.0f];
    UIColor *chipletterColor = [UIColor blackColor];
    for (int i=0; i<_BEGIN_CHIP_NUM; i++) {
        CGPoint temPt = CGPointMake([[_circlePtArr objectAtIndex:i] CGPointValue].x-14,[[_circlePtArr objectAtIndex:i] CGPointValue].y-22);
        [_chipLocation[i] drawAtPoint:temPt withAttributes:@{NSFontAttributeName:chipFont,NSForegroundColorAttributeName:chipletterColor}];
    }
    
    // 交換回数表示
    NSString *str = [NSString stringWithFormat:@"%d times changed", _cnt];
    UIFont *counterFont = [UIFont fontWithName:@"ArialMT" size:24.0f];
    UIColor *counterletterColor = [UIColor whiteColor];
    [str drawAtPoint:CGPointMake(150,10) withAttributes:@{NSFontAttributeName:counterFont,NSForegroundColorAttributeName:counterletterColor}];
    
    // 状態表示メッセージ
    UIFont *messaFont = [UIFont fontWithName:@"ArialMT" size:24.0f];
    UIColor *messaletterColor = [UIColor blueColor];
    UIColor *messaBgcolor = [UIColor grayColor];
    [_stateMessage drawAtPoint:CGPointMake(140,330) withAttributes:@{NSFontAttributeName:messaFont,NSForegroundColorAttributeName:messaletterColor,NSBackgroundColorAttributeName:messaBgcolor}];
    
}

- (BOOL)judgeChipcolor:(NSString *)chip
{
    BOOL ret;
    if ([chip isEqual:@"A"] || [chip isEqual:@"C"] || [chip isEqual:@"E"] || [chip isEqual:@"G"] || [chip isEqual:@"I"] || [chip isEqual:@"K"]) {
        // 銀貨
        ret=NO;
    } else {
        // 金貨
        ret=YES;
    }
    return ret;
}

// タッチ開始イベント
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // スワイプ開始位置を点で取得
    CGPoint startPt = [[touches anyObject] locationInView:self];
    
    for (int i=0; i<_BEGIN_CHIP_NUM; i++) {
        NSValue *tempRect = [_circleRectArr objectAtIndex:i];
        // タッチ位置と丸の位置の判定
        if (CGRectContainsPoint([tempRect CGRectValue],startPt)){
            // 交換可能な隣接コインのチェック
            // 自分のコイン色と隣のコイン色を比べて_nextChipsに格納
            for (int j=0; j<3; j++) {
                if ([_adjacency[i][j] intValue]<_BEGIN_CHIP_NUM) {
                    if ([self judgeChipcolor:_chipLocation[i]]!=[self judgeChipcolor:_chipLocation[[_adjacency[i][j] intValue]]]) {
                        _nextChips[j]=_adjacency[i][j];
                    }
                }
            }
            _selectedChip = i;
            _isSelected = YES;
            [self setNeedsDisplay];
        }
    }
}
// タッチ終了イベント
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // スワイプ終了位置を点で取得
    CGPoint endPt = [[touches anyObject] locationInView:self];
    
    if (_isSelected) {
        int hit=0;
        for (int i=0; i<_BEGIN_CHIP_NUM; i++) {
            NSValue *tempRect = [_circleRectArr objectAtIndex:i];
            // タッチ位置と丸の位置の判定
            if (CGRectContainsPoint([tempRect CGRectValue],endPt)){
                // 隣のコインの色をチェック、終点のコインをチェック
                // 自分のコイン色と隣のコイン色を比べて、異なれば交換してメッセージ送信
                for (int j=0; j<3; j++) {
                    if (i==[_nextChips[j] intValue]) {
                        // コイン入れ替え
                        NSString *memo=_chipLocation[_selectedChip];
                        _chipLocation[_selectedChip]=_chipLocation[i];
                        _chipLocation[i]=memo;
                        _cnt++;
                        hit++;
                        
                        // 事後処理
                        _stateMessage=@"Changed";
                    }
                }
            }
        }
        _isSelected = NO;
        _selectedChip = 10001;
        _nextChips = [@[@10001,@10001,@10001] mutableCopy];
        if (hit==0) {
            _stateMessage=@"Cancelled";
        }
        [self setNeedsDisplay];
    }
}

@end
