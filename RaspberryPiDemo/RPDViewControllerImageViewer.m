//
//  RPDViewControllerImageViewer.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerImageViewer.h"
#import "RPDDefine.h"


@interface RPDViewControllerImageViewer ()
@property UIButton *btnClose;
@property UIImage *img;
@property UIImageView *imgv;
@end

@implementation RPDViewControllerImageViewer

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithImage:(UIImage*)img
{
    _img = img; //下の[super init]内でviewDidLoadが呼ばれるようなので、引数の値は先に保存しておく。
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
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    const int BUTTON_WIDTH = 120;
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnClose = btn;
        [_btnClose setTitle:@"閉じる" forState:UIControlStateNormal];
        _btnClose.frame = CGRectMake(0,HEADER_HEIGHT/4,BUTTON_WIDTH,30);
        [btn addTarget:self action:@selector(closeButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
        //    [_imgv1 addSubview:btn];
        [self.view addSubview:btn];
    }
    [self setImageView];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    // ピンチ
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handlePinchGesture:)];
//    [self.view addGestureRecognizer:pinchGesture];
    [_imgv addGestureRecognizer:pinchGesture];
}

-(void)closeButtonDidPush
{
    //自身を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)createImageViewWithImage:(UIImage*)img
{
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)setImageView
{
    _imgv = [self createImageViewWithImage:_img];
    CGSize frameSize = self.view.frame.size;
    _imgv.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT));
    _imgv.contentMode = UIViewContentModeScaleAspectFit; //アスペクト比を維持したまま 画像のすべてが表示されるようにリサイズ
    _imgv.clipsToBounds = YES;
    [self.view addSubview:_imgv];
    
}

// セレクター
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    CGFloat factor = [(UIPinchGestureRecognizer *)sender scale];
    self.view.transform = CGAffineTransformMakeScale(factor, factor);
    
    NSLog(@"factor %f",factor);
    
}

@end
