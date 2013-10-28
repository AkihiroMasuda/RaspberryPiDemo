//
//  RPDAutoStateMahcine.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDAutoStateMachine.h"

@interface RPDAutoStateMachine ()
@property RPDViewControllerAuto* vcAuto;
@property int curStatus;
@property int imgIndex;
@end


@implementation RPDAutoStateMachine



- (id) initWith:(RPDViewControllerAuto*)vcAuto;
{
    self = [super init];
    if (self){
        _vcAuto = vcAuto;
        _curStatus = STATUS_UNKNOWN;
        _imgIndex = 0;
    }
    return self;
}

// イベントディスパッチャ
- (void) dispatchEvent:(int)event
{
    int oldStatus = _curStatus;
    // 今の状態に対する処理
    switch(_curStatus) {
        case STATUS_UNKNOWN:
            [self statusUnknown:event];
            break;
        case STATUS_INIT:
            [self statusInit:event];
            break;
        case STATUS_DIST:
            [self statusDistributionCalc:event];
            break;
        case STATUS_FIN:
            [self statusFinished:event];
            break;
    }
    // 状態が変更されたときの処理
    if (oldStatus != _curStatus){
        switch(_curStatus) {
            case STATUS_INIT:
                [self statisInitEntry];
                break;
            case STATUS_DIST:
                [self statusDistributionCalcEntry];
                break;
            case STATUS_FIN:
                [self statusFinishedEntry];
                break;
        }
    }
}

///// 未初期化状態
- (void) statisUnknownEntry
{
}

- (void) statusUnknown:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            break;
        case EVENT_INIT:
            _curStatus = EVENT_INIT;
            break;
    }
}


///// 初期状態
- (void) statisInitEntry
{
    // 画面を初期化。(1枚目を表示。2枚目をクリア)
    [self addIndex];
    [self loadFirstImageView];

    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    
}

- (void) statusInit:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_DIST;
            break;
        case EVENT_INIT:
            // TODO: 何もしなくて良いと思われる
            break;
    }
}

///// 分散処理中状態
- (void) statusDistributionCalcEntry
{
    // 分散処理開始
    
    // グルグルを表示
    
    // 分散処理が終わったらEVENT_NEXT命令を発行するように仕掛ける
}
- (void) statusDistributionCalc:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_FIN;
            break;
        case EVENT_INIT:
            // TODO: 状態をINITに変える。分散処理を中断する
            _curStatus = STATUS_INIT;
            break;
    }
}

///// 完了状態
- (void) statusFinishedEntry
{
    // 分散処理結果を使って画面を更新
    
    // タイマーを発行。一定時間後にEVENT_NEXTを発行
}
- (void) statusFinished:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_INIT;
            break;
        case EVENT_INIT:
            // TODO: 状態をINITに変える。必要ならタイマーの終了処理を
            _curStatus = STATUS_INIT;
            break;
    }
}



////// 内部メソッド

///  内部メソッド
- (void)addIndex
{
    ++_imgIndex;
    if (_imgIndex >= [_vcAuto.imgSamples count]){
        _imgIndex = 0;
    }
}

- (UIImageView *)createImageViewWithName:(NSString*)name
{
    UIImage *img1 = [UIImage imageNamed:name];
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img1];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)loadFirstImageView
{
    // 画面の上半分に配置
    {
        int index = _imgIndex;
        NSString *st =[_vcAuto.imgSamples objectAtIndex:index];
        UIImageView *imgview1 = [self createImageViewWithName:st];
        CGSize frameSize = _vcAuto.view.frame.size;
        imgview1.frame = CGRectMake(0, 0, frameSize.width, frameSize.height/2);
        [_vcAuto.view addSubview:imgview1];
    }
    
}

- (void)loadSecondImageView
{
    // 画面の下半分に配置
    {
        UIImageView *imgview2 = [self createImageViewWithName:@"img1.png"];
        CGSize frameSize = _vcAuto.view.frame.size;
        imgview2.frame = CGRectMake(0, frameSize.height/2, frameSize.width, frameSize.height/2);
        [_vcAuto.view addSubview:imgview2];
    }
}

@end

