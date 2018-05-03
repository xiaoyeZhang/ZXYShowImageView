//
//  ZXYScrollView.h
//  ZXYShowImageView
//
//  Created by 张晓烨 on 2018/4/13.
//  Copyright © 2018年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXYScrollViewDelegate<NSObject>

- (void)successClickDelegate:(NSInteger)num;

@end

@interface ZXYScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setUpViewWithImageUrls:(NSArray *)aUrls imgage:(NSArray *)aMessage;

@property (nonatomic ,strong) id<ZXYScrollViewDelegate> delegate;

@property (nonatomic ,readwrite) BOOL isPageControl; /// 隐藏Page

@property (nonatomic ,readwrite) BOOL isMessageLabel; /// 隐藏信息控件

@end
