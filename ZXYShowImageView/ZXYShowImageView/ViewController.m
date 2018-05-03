//
//  ViewController.m
//  ZXYShowImageView
//
//  Created by 张晓烨 on 2018/5/3.
//  Copyright © 2018年 zxy. All rights reserved.
//

#import "ViewController.h"
#import "TimeImageScrollViewController.h"
#import "Drop_downViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTabelView];
}

#pragma mark tableview
- (void)addTabelView{
    
    tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"无限滚动图片";
    }else{
        cell.textLabel.text = @"图片下拉放大效果";
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        TimeImageScrollViewController *vc = [[TimeImageScrollViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        Drop_downViewController *vc = [[Drop_downViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
