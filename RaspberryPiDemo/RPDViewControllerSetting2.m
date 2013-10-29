//
//  RPDViewControllerSetting2.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/29.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerSetting2.h"
#import "RPDDefine.h"

@interface RPDViewControllerSetting2 ()

@end

@implementation RPDViewControllerSetting2

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
    [_NumOfSampleImages setText:NUM_OF_SAMPLE_IMAGES];
    [_srcLongSize setText:SRC_LONG_SIZE];
    [_requestURL setText:REQUEST_URL];
    [_workersIP setText:WORKERS_IP];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
