//
//  DrawingView.h
//  CoinChangePuzzle
//
//  Created by macbook on 2015/04/26.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView

// コインの描画情報
@property NSArray *circlePtArr;
@property NSArray *circleRectArr;
// コインの隣接関係
@property NSArray *adjacency;

// そのた変数
@property int BEGIN_CHIP_NUM;
@property int MAXPATH;
@property BOOL isSelected;
@property int cnt;
@property int selectedChip;
@property NSString *stateMessage;
@property NSMutableArray *nextChips;
@property NSMutableArray *chipLocation;

@end
