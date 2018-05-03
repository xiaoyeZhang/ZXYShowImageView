//
//  TimeImageScrollViewController.m
//  ZXYShowImageView
//
//  Created by 张晓烨 on 2018/4/18.
//  Copyright © 2018年 zxy. All rights reserved.
//

#import "TimeImageScrollViewController.h"
#import "ZXYScrollView.h"

#define BARFRAME_NAVBAR_HEIGHT self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height
@interface TimeImageScrollViewController ()<ZXYScrollViewDelegate>
{
    NSArray *arr1;
}

@end

@implementation TimeImageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png",
                     @"http://img.zcool.cn/community/01f09e577b85450000012e7e182cf0.jpg@1280w_1l_2o_100sh.jpg",
                     @"http://img.zcool.cn/community/010f87596f13e6a8012193a363df45.jpg@1280w_1l_2o_100sh.jpg",
                     @"http://img.zcool.cn/community/018d4e554967920000019ae9df1533.jpg@900w_1l_2o_100sh.jpg",
                     @"http://img.zcool.cn/community/010a1b554c01d1000001bf72a68b37.jpg@1280w_1l_2o_100sh.png",
                     @"http://pic.58pic.com/58pic/15/57/84/70H58PICCJt_1024.jpg"
                     ];

    arr1 = @[@"第一张图",
             @"第二张图",
             @"第三张图",
             @"第四张图",
             @"第五张图",
             @"第六张图"
             ];
    
    ZXYScrollView *scrollView = [[ZXYScrollView alloc] initWithFrame:CGRectMake(0, BARFRAME_NAVBAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, 200)];
    scrollView.delegate = self;
    [scrollView setUpViewWithImageUrls:arr imgage:arr1];
    [self.view addSubview:scrollView];
    
    
}

- (void)successClickDelegate:(NSInteger)num{
    
    
    NSLog(@"----------%ld ---- %@",num,arr1[num]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
