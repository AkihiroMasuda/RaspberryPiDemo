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

@end
