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
    
    NSArray *arr = @[[UIColor redColor],
                     [UIColor orangeColor],
                     [UIColor yellowColor],
                     [UIColor greenColor],
                     [UIColor blueColor],
                     [UIColor purpleColor]];
    
    arr1 = @[@"第一张图",
             @"第二张图",
             @"第三张图",
             @"第四张图",
             @"第五张图",
             @"第六张图"];
    
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
