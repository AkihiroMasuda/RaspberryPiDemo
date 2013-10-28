//
//  RPDViewController02.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerAuto.h"
#import "RPDAutoStateMachine.h"

@interface RPDViewControllerAuto ()
@property RPDAutoStateMachine* stateMachine;
@end


@implementation RPDViewControllerAuto

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _stateMachine = [[RPDAutoStateMachine alloc] initWith:self];
    self.view.backgroundColor = [UIColor yellowColor];
    _imgSamples = [NSArray arrayWithObjects:@"02.jpeg", @"02.jpeg", nil];
//    _imgIndex = 0;

    // 初期化命令を発行
    [_stateMachine dispatchEvent:EVENT_INIT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// implement protcol
- (void)tabBarDidSelect
{
    // 初期化命令を発行
    [_stateMachine dispatchEvent:EVENT_INIT];
}
//
/////  内部メソッド
//- (void)addIndex
//{
//    ++_imgIndex;
//    if (_imgIndex >= [_imgSamples count]){
//        _imgIndex = 0;
//    }
//}
//
//- (UIImageView *)createImageViewWithName:(NSString*)name
//{
//    UIImage *img1 = [UIImage imageNamed:name];
//    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img1];
//    imgview1.contentMode = UIViewContentModeScaleAspectFill;
//    imgview1.clipsToBounds = YES;
//    return imgview1;
//}
//
//- (void)loadFirstImageView
//{
//    // 画面の上半分に配置
//    {
//        int index = _imgIndex;
//        NSString *st =[_imgSamples objectAtIndex:index];
//        UIImageView *imgview1 = [self createImageViewWithName:st];
//        CGSize frameSize = self.view.frame.size;
//        imgview1.frame = CGRectMake(0, 0, frameSize.width, frameSize.height/2);
//        [self.view addSubview:imgview1];
//    }
//    
//}
//
//- (void)loadSecondImageView
//{
//    // 画面の下半分に配置
//    {
//        UIImageView *imgview2 = [self createImageViewWithName:@"img1.png"];
//        CGSize frameSize = self.view.frame.size;
//        imgview2.frame = CGRectMake(0, frameSize.height/2, frameSize.width, frameSize.height/2);
//        [self.view addSubview:imgview2];
//    }
//}


@end
