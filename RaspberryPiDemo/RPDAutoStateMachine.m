//
//  RPDAutoStateMahcine.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDAutoStateMachine.h"
#import "MBProgressHUD.h"

#define TIMER_INTERVAL (3.0f)

@interface RPDAutoStateMachine ()
@property RPDViewControllerAuto* vcAuto;
@property int curStatus;
@property int imgIndex;
@property UIImageView* img1;
@property UIImageView* img2;
@property NSTimer* timer;
@property MBProgressHUD* hud;
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
    ///
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
    [self clearImageViews];
    [self addIndex];
    [self loadFirstImageView];

    
    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    [self makeAndStartTimerForEventNext];
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
    [self makeAndShowIndicator];
    
    // 分散処理が終わったらEVENT_NEXT命令を発行するように仕掛ける
//    [self dispatchEvent:EVENT_NEXT];

    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    [self makeAndStartTimerForEventNext];
}
- (void) statusDistributionCalc:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            [self clearIndicator];
            _curStatus = STATUS_FIN;
            break;
        case EVENT_INIT:
            // TODO: 状態をINITに変える。分散処理を中断する
            [self clearIndicator];
            [self clearTimer];
            _curStatus = STATUS_INIT;
            break;
    }
}

///// 完了状態
- (void) statusFinishedEntry
{
    // 分散処理結果を使って画面を更新
    [self loadSecondImageView];
    
    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    [self makeAndStartTimerForEventNext];
}
- (void) statusFinished:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_INIT;
            break;
        case EVENT_INIT:
            // TODO: 状態をINITに変える。必要ならタイマーの終了処理を
            [self clearTimer];
            _curStatus = STATUS_INIT;
            break;
    }
}



////// 内部メソッド
- (NSTimer*) makeAndStartTimerForEventNext
{
    NSTimer *timer = [NSTimer
                      // タイマーイベントを発生させる感覚。「1.5」は 1.5秒 型は float
                      scheduledTimerWithTimeInterval:TIMER_INTERVAL
                      // 呼び出すメソッドの呼び出し先(selector) self はこのファイル(.m)
                      target:self
                      // 呼び出すメソッド名。「:」で自分自身(タイマーインスタンス)を渡す。
                      // インスタンスを渡さない場合は、「timerInfo」
                      selector:@selector(timerInfoEventNext:)
                      // 呼び出すメソッド内で利用するデータが存在する場合は設定する。ない場合は「nil」
                      userInfo:nil
                      // 上記で設定した秒ごとにメソッドを呼び出す場合は、「YES」呼び出さない場合は「NO」
                      repeats:NO
                      ];
    _timer = timer;
    return timer;
}

-(void) timerInfoEventNext:(NSTimer *)timer
{
    [self dispatchEvent:EVENT_NEXT];
}

-(void) clearTimer
{
    if (_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) makeAndShowIndicator
{
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_vcAuto.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_img1 animated:YES];
    hud.labelText = @"分散処理実施中";
    _hud = hud;
}

- (void) clearIndicator
{
    [_hud hide:true];
    _hud = nil;
}

- (void) makeAndShowIndicator2
{
    // ローディングビュー作成
//    UIView *loadingView = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
    UIView *loadingView = [[UIView alloc] initWithFrame:_vcAuto.view.bounds];
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.alpha = 0.5f;
    
    int w = _vcAuto.view.frame.size.width;
    int h = _vcAuto.view.frame.size.height;
    
//    
//    int w = loadingView.bounds.size.width;
//    int h = loadingView.bounds.size.height;
    
    // インジケータ作成
//    CGRect rc = CGRectMake(0, 0, 200, 200);
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:rc];
    [indicator setCenter:CGPointMake(loadingView.bounds.size.width / 2, loadingView.bounds.size.height / 2)];
    
    // ビューに追加
    [loadingView addSubview:indicator];
//    [self.navigationController.view addSubview:loadingView];
    [_vcAuto.view addSubview:loadingView];
    
    // インジケータ再生
    [indicator startAnimating];}

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

- (void)clearImageViews
{
    if (_img1!=NULL){
        [_img1 removeFromSuperview];
    }
    if (_img2!=NULL){
        [_img2 removeFromSuperview];
    }
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
        _img1 = imgview1;
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
        _img2 = imgview2;
    }
}

@end

