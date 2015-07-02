//
//  TakePhotoViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-7-24.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "TakePhotoViewController.h"
#import <ImageIO/ImageIO.h>
#import "NZAlertView.h"

#import <AudioToolbox/AudioToolbox.h>
@interface TakePhotoViewController (){
    AVCaptureSession *_session;//它是input和output的桥梁。它协调着intput到output的数据传输。
    AVCaptureDeviceInput *_captureInput;
    AVCaptureStillImageOutput *_captureOutput;
    AVCaptureVideoPreviewLayer *_preview;
    AVCaptureDevice *_device;//这里代表抽象的硬件设备。
    UIImage *_finishImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *successedPic;//成功拍摄图片
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;//拍摄按钮
@property (weak, nonatomic) IBOutlet UIButton *positionButton;//自拍or正常拍摄按钮
@property (weak, nonatomic) IBOutlet UIButton *flashButton;//闪光灯
@property (weak, nonatomic) IBOutlet UIView *cameraView;//拍摄层
@property (weak, nonatomic) IBOutlet UIButton *saveButton;//保存图片
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;//取消保存or返回上一界面


//按钮事件
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)changePosition:(UIButton *)sender;
- (IBAction)takeLine:(UIButton *)sender;
- (IBAction)savePic:(UIButton *)sender;
- (IBAction)cancelSave:(UIButton *)sender;


@property(assign,nonatomic)BOOL takeSuccessedful;//是否拍摄完毕
@property(assign,nonatomic)BOOL takeSelf;//是否自拍
@end

@implementation TakePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
// [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
  
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
  
 
    [self initialize];
    
    
    //[self addAudioSessionInitialize];
}
#pragma -mark-   ***********基本配置***********
/*
#pragma -mark 监听按键事件
-(void)addAudioSessionInitialize{
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    
    AudioSessionSetActive(true);
    
    AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume ,
                                    
                                    volumeListenerCallback,
                                    
                                    (__bridge void *)(self)
                                    
                                    );
}
#pragma -mark 监听方法
void volumeListenerCallback (
                             
                             void                      *inClientData,
                             
                             AudioSessionPropertyID    inID,
                             
                             UInt32                    inDataSize,
                             
                             const void                *inData
                             
                             ){
    
    const float *volumePointer = inData;
    float volume = *volumePointer;
    
    CLog(@"音量：%f",volume);
    
}
 */
#pragma -mark 初始化页面
- (void) initialize
{
    self.takeSuccessedful=NO;
    self.takeSelf=NO;
    
    //1.创建会话层
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPreset640x480];
    
    
    //  闪光灯
    //2.创建、配置输入设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [_device lockForConfiguration:nil];
    [_device unlockForConfiguration];
    
	NSError *error;
	_captureInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
	if (!_captureInput)
	{
		CLog(@"Error: %@", error);
		return;
	}
    [_session addInput:_captureInput];
    
    
    //3.创建、配置输出
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_captureOutput setOutputSettings:outputSettings];
	[_session addOutput:_captureOutput];
    
    //照相曾
    _preview = [AVCaptureVideoPreviewLayer layerWithSession: _session];
    _preview.frame = self.cameraView.bounds;
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.cameraView.layer addSublayer:_preview];
    
    [_session startRunning];
}





#pragma -mark-   ***********按钮事件***********
#pragma -mark 点击照相
- (IBAction)takePhoto:(UIButton *)sender {
    //get connection
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in _captureOutput.connections) {
        
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            
            break;
            
        }
    }
    //get UIImage
    [_captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         _takePhotoButton.hidden=YES;
         _saveButton.hidden = NO;
         _positionButton.hidden=YES;
         _flashButton.hidden=YES;
         self.takeSuccessedful=YES;
         [_session stopRunning];
      
         
         CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
         }
//     得到照片但是自拍是反的
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *last  = [[UIImage alloc] initWithData:imageData];
         if (self.takeSelf ) {
             CLog(@"自拍！");
            
             CGRect rect=CGRectMake(0, 0, 320*2, (self.cameraView.frame.size.height)*2);
             CLog(@"%@",NSStringFromCGRect(rect));
              //获得反的照片
             _finishImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([last CGImage], rect) scale:1 orientation:UIImageOrientationLeftMirrored];
         }else{
             CLog(@"正常拍摄！");
             _finishImage=last;
         }
         

         self.successedPic.image=_finishImage;
         [self.cameraView bringSubviewToFront:self.successedPic];
         

     }];

}

#pragma -mark 改变照相方式
- (IBAction)changePosition:(UIButton *)sender {
    //添加动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = .3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"oglFlip";
    if (_device.position == AVCaptureDevicePositionFront) {
        animation.subtype = kCATransitionFromRight;
    }
    else if(_device.position == AVCaptureDevicePositionBack){
        animation.subtype = kCATransitionFromLeft;
    }
    [_preview addAnimation:animation forKey:@"animation"];
    
    NSArray *inputs = _session.inputs;
    for ( AVCaptureDeviceInput *input in inputs )
    {
        AVCaptureDevice *device = input.device;
        if ([device hasMediaType:AVMediaTypeVideo])
        {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
            {
                self.takeSelf=NO;
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
                CLog(@"正常拍摄");
            }
            else
            {
                  self.takeSelf=YES;
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                 CLog(@"自拍");
            }
            _device = newCamera;
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [_session beginConfiguration];
            
            [_session removeInput:input];
            [_session addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [_session commitConfiguration];
            break;
        }
    }

}
#pragma -mark 改变照相方式方法
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

#pragma -mark 是否打开闪光灯
- (IBAction)takeLine:(UIButton *)sender {
    
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] && [_device hasFlash])
    {
        [_flashButton setEnabled:NO];
        [_device lockForConfiguration:nil];
        
        if([_device flashMode] == AVCaptureFlashModeOff)
        {
            [_device setFlashMode:AVCaptureFlashModeAuto];
            [_flashButton setImage:[UIImage imageNamed:@"camera_flash_auto.png"] forState:UIControlStateNormal];
        }
        else if([_device flashMode] == AVCaptureFlashModeAuto)
        {
            [_device setFlashMode:AVCaptureFlashModeOn];
            [_flashButton setImage:[UIImage imageNamed:@"camera_flash_on.png"] forState:UIControlStateNormal];
        }
        else{
            [_device setFlashMode:AVCaptureFlashModeOff];
            [_flashButton setImage:[UIImage imageNamed:@"camera_flash_off.png"] forState:UIControlStateNormal];
        }

        
        [_device unlockForConfiguration];
        
        [_flashButton setEnabled:YES];
    }

}
#pragma -mark 储存照片
- (IBAction)savePic:(UIButton *)sender {

    
  UIImageWriteToSavedPhotosAlbum(_finishImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
#pragma -mark 取消储存照片
- (IBAction)cancelSave:(UIButton *)sender {
    if (self.takeSuccessedful==YES) {
        [self takeAgainPhoto];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
#pragma -mark 再照一次
-(void)takeAgainPhoto{
    _saveButton.hidden = YES;
    _positionButton.hidden=NO;
    _flashButton.hidden=NO;
    [_session startRunning];
    self.takeSuccessedful=NO;
    
    //
    self.successedPic.image=nil;
    [self.cameraView sendSubviewToBack:self.successedPic];
}
#pragma -mark 照片存储成功或者失败
-(void) image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message…
        CLog(@"存储失败");
        NZAlertView *alertView=[[NZAlertView alloc]initWithStyle:NZAlertStyleError
                                                  statusBarColor:nil
                                                           title:@"失败！"
                                                         message:@"保存失败！"];
        [alertView showWithCompletion:^{
             [self takeAgainPhoto];
        }];
    }
    else  // No errors
    {
        
        CLog(@"存储成功");
        
        
        NZAlertView *alertView=[[NZAlertView alloc]initWithStyle:NZAlertStyleSuccess
                                                  statusBarColor:nil
                                                           title:@"恭喜！"
                                                         message:@"保存成功！"];
        [alertView showWithCompletion:^{
           [self takeAgainPhoto];
        }];
        
    }
}

@end
