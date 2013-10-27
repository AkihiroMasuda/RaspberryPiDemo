//
//  RPDViewController02.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerAuto.h"

@interface RPDViewControllerAuto ()

@property NSMutableArray *imgSamples;

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
    self.view.backgroundColor = [UIColor yellowColor];
    _imgSamples = [NSArray arrayWithObjects:@"04.jpeg", @"02.jpeg", nil];
    
	// Do any additional setup after loading the view.
    // 画面の上半分に配置
    {
        NSString *st =[_imgSamples objectAtIndex:0];
        UIImageView *imgview1 = [self createImageViewWithName:st];
        CGSize frameSize = self.view.frame.size;
        imgview1.frame = CGRectMake(0, 0, frameSize.width, frameSize.height/2);
        [self.view addSubview:imgview1];
    }
    
    // 画面の下半分に配置
    {
        UIImageView *imgview2 = [self createImageViewWithName:@"img1.png"];
        CGSize frameSize = self.view.frame.size;
        imgview2.frame = CGRectMake(0, frameSize.height/2, frameSize.width, frameSize.height/2);
        [self.view addSubview:imgview2];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// implement protcol
- (void)tabBarDidSelect
{
    // 自身がタブバーで選択された時に呼ばれる
    int hoge = 9;
}
@end
