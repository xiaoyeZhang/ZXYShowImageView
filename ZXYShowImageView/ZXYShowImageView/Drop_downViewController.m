//
//  Drop_downViewController.m
//  ZXYShowImageView
//
//  Created by 张晓烨 on 2018/4/18.
//  Copyright © 2018年 zxy. All rights reserved.
//

#import "Drop_downViewController.h"

@interface Drop_downViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UIImageView *headView;
}
@end

@implementation Drop_downViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    headView = [[UIImageView alloc] init];
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.image = [UIImage imageNamed:@"head"];
    
    [self.view addSubview:headView];
    
    [self addTabelView];
    
}

#pragma mark tableview
- (void)addTabelView{
    
    tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.textLabel.text = @"text";
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect newFrame = headView.frame;
    CGFloat settingViewOffsetY = 50 - scrollView.contentOffset.y;
    newFrame.size.height = settingViewOffsetY;
    
    if (settingViewOffsetY < 50) {
        newFrame.size.height = 50;
    }
    headView.frame = newFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
