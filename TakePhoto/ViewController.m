//
//  ViewController.m
//  TakePhoto
//
//  Created by GerryLin on 12/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *takephotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 100)];
    takephotoBtn.center = self.view.center;
    [takephotoBtn setTitle:@"Take Photo" forState:UIControlStateNormal];
    [takephotoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    takephotoBtn.layer.borderWidth = 1.0f;
    takephotoBtn.layer.masksToBounds = YES;
    takephotoBtn.layer.cornerRadius = 5.0f;
    takephotoBtn.layer.borderColor = [[UIColor blueColor]CGColor];
    [takephotoBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takephotoBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)takePhoto:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"拍照"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Function for take photo
                                                           [self TakePhotoByCamera];
                                                       }];
    [alertController addAction:moreAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"從相簿選擇照片"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action){
                                                         //Function for search photo
                                                         [self SearchPhotoByPhone];
                                                     }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) TakePhotoByCamera{
    //1.创建相册选取器
    UIImagePickerController *Imagepicker = [[UIImagePickerController alloc] init];
    //2.设置代理  UIImagePickerController有两个协议：UINavigationControllerDelegate  UIImagePickerControllerDelegate
    
    Imagepicker.delegate = self;
    //3.设置来源
    
    //   UIImagePickerControllerSourceTypePhotoLibrary,相册  (手机相簿)
    //   UIImagePickerControllerSourceTypeCamera,相机（模拟器不支持）
    //   UIImagePickerControllerSourceTypeSavedPhotosAlbum，相册（手机照片）
    
    Imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //4.允许编辑
    Imagepicker.allowsEditing = NO;
    //5.弹出相册选取器
    [self presentViewController:Imagepicker animated:YES completion:nil];
    
}

- (void) SearchPhotoByPhone{
    //1.创建相册选取器
    UIImagePickerController *Imagepicker = [[UIImagePickerController alloc] init];
    //2.设置代理  UIImagePickerController有两个协议：UINavigationControllerDelegate  UIImagePickerControllerDelegate
    
    Imagepicker.delegate = self;
    //3.设置来源
    
    //   UIImagePickerControllerSourceTypePhotoLibrary,相册  (手机相簿)
    //   UIImagePickerControllerSourceTypeCamera,相机（模拟器不支持）
    //   UIImagePickerControllerSourceTypeSavedPhotosAlbum，相册（手机照片）
    
    Imagepicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //4.允许编辑
    Imagepicker.allowsEditing = YES;
    //5.弹出相册选取器
    [self presentViewController:Imagepicker animated:YES completion:nil];
    
}
/*
 //2.完成选取  该方法与下面方法1唯一的区别就是将编辑之后的图片image作为参数暴露在外部,而方法二则需要从字典中获取图片
 - (void)imagePickerController:(UIImagePickerController *)Imagepicker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
 {
 [Imagepicker dismissViewControllerAnimated:YES completion:nil];
 NSLog(@"%@",editingInfo);
 NSLog(@"%@",image);
 [BoderImg setImage:image];
 avatar = UIImageJPEGRepresentation(image, 0.5);
 
 }
 */

//1.完成选取
- (void)imagePickerController:(UIImagePickerController *)Imagepicker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [Imagepicker dismissViewControllerAnimated:YES completion:nil];
    //    info中包括选取的照⽚片,视频的主要信息
    //    NSString *const UIImagePickerControllerMediaType; 选取的类型 public.image public.movie
    //    NSString *const UIImagePickerControllerOriginalImage; 修改前 的UIImage object.
    //    NSString *const UIImagePickerControllerEditedImage; 修改后 的UIImage object.
    //    NSString *const UIImagePickerControllerCropRect; 原始图 ⽚片的尺⼨寸NSValue object containing a CGRect data type
    //    NSString *const UIImagePickerControllerMediaURL; 视频在⽂文件系统中 的 NSURL地址
    //    保存视 频主要时通过获取其NSURL 然后转换成NSData
    UIImage *image = info[UIImagePickerControllerEditedImage];
}

//取消选取
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)Imagepicker
{
    [Imagepicker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
