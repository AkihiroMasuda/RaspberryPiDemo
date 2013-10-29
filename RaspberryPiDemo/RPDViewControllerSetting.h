//
//  RPDViewControllerSetting.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPDViewControllerBase.h"

@interface RPDViewControllerSetting : UIViewController <RPDTabBarChildProtocol>
@property (weak, nonatomic) IBOutlet UITextField *numOfSampleImages;
@property (weak, nonatomic) IBOutlet UITextField *srcLongSize;
@property (weak, nonatomic) IBOutlet UITextField *requestURL;
@property (weak, nonatomic) IBOutlet UITextField *workersIP;

@end
