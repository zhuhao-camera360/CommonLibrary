//
//  ViewController.m
//  CommonLibrarySimple
//
//  Created by zhuhao on 15/5/10.
//  Copyright (c) 2015年 zhuhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    _imageVIew.image = [UIImage waterMarkImageWithImage:[UIImage imageNamed:@"vip.jpg"] info:@"@hauk"];
    _imageVIew.image = [UIImage waterMarkImageWithImage:[UIImage imageNamed:@"vip.jpg"] markImage:[UIImage imageNamed:@"markimage.jpg"] atPoint:CGPointMake(10, 10) waterAlpha:0];;
    
    CGFloat ver = [AppSettingHelper getAppCurrentVersion];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _imageVIew.frame = CGRectMake(0, 0, _imageVIew.image.size.width,  _imageVIew.image.size.height);
    _imageVIew.center = self.view.center;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
