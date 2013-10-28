//
//  RPDViewController01.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerCamera.h"

#import "RPDDefine.h"


@interface RPDViewControllerCamera ()
@property UIButton *btn;
@property BOOL isUsePopOver;
@property UIPopoverController* imagePopController;
@property UIImage *img1;
@property UIImageView *imgv1;
@end

@implementation RPDViewControllerCamera

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ボタンを追加
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn = btn;
    [_btn setTitle:@"撮影" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(0,HEADER_HEIGHT/4,120,30);
    [btn addTarget:self action:@selector(buttonDidPush) forControlEvents:UIControlEventTouchUpInside];
    //    [_imgv1 addSubview:btn];
    [self.view addSubview:btn];
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
    
}

-(void)buttonDidPush
{
    NSLog(@"Cancel pushed.");
    
    id sender = _btn;
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;  //カメラ使用
    //    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary; //ライブラリから取得
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        UIImagePickerController* imagepicker = [UIImagePickerController new];
        imagepicker.sourceType = type;
        imagepicker.delegate = self;
        
        _isUsePopOver = false;
        if(type == UIImagePickerControllerSourceTypePhotoLibrary){
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                NSLog(@"iPhoneの処理");
                imagepicker.allowsEditing = true;
                [self presentViewController:imagepicker animated:YES completion:^{
                    //
                    NSLog(@"カメラ開いた");
                }];
            }
            else{
                NSLog(@"iPadの処理");
                // iPad の場合は、画像選択はポップオーバーからやらないとダメ。
                // 表示に使うPopoverのインスタンスを作成する。 imagePopControllerは、UIPopoverController型のフィールド変数。
                // PopoverのコンテンツビューにImagePickerを指定する。
                _imagePopController = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
                
                // Popoverを表示する。
                // senderはBarButtonItem型の変数で、このボタンを起点にPopoverを開く。
                [_imagePopController presentPopoverFromBarButtonItem:sender
                                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                                           animated:YES];
                _isUsePopOver = true;
            }
        }else{
            imagepicker.allowsEditing = true;
            [self presentViewController:imagepicker animated:YES completion:^{
                //
                NSLog(@"カメラ開いた");
            }];
        }
        
    }
    
    
}


// 撮影終わって画像を確定したあとで呼ばれる
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* originalImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* editedImage = (UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
    
//    _img1 = originalImage;
    _img1 = editedImage;
    
    // 上半分に画像を描画
    [self loadFirstImageView];
    
    if (_isUsePopOver){
        // ポップオーバーを消す
        [_imagePopController dismissPopoverAnimated:YES];
    }else{
        // カメラ撮影ビューコントローラを閉じる
        [self dismissViewControllerAnimated:true completion:^{}];
    }
    
}



- (UIImageView *)createImageViewWithImage:(UIImage*)img
{
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)loadFirstImageView
{
    // 画面の上半分に配置
    {
        UIImageView *imgview1 = [self createImageViewWithImage:_img1];
        CGSize frameSize = self.view.frame.size;
        imgview1.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2);
//        imgview1.contentMode = UIViewContentModeScaleAspectFill; //アスペクト比を維持したまま Viewに空きがないように表示
        imgview1.contentMode = UIViewContentModeScaleAspectFit; //アスペクト比を維持したまま 画像のすべてが表示されるようにリサイズ
        imgview1.clipsToBounds = YES;
        [self.view addSubview:imgview1];
        _imgv1 = imgview1;
    }
}

@end
