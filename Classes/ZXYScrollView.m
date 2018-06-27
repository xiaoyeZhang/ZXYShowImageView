//
//  ZXYScrollView.m
//  ZXYShowImageView
//
//  Created by 张晓烨 on 2018/4/13.
//  Copyright © 2018年 zxy. All rights reserved.
//

#import "ZXYScrollView.h"
#import "UIImageView+WebCache.h"

@interface ZXYScrollView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView              *mainScrollView;
@property (nonatomic ,strong) UIImageView               *leftImageView;
@property (nonatomic ,strong) UIImageView               *middleImageView;
@property (nonatomic ,strong) UIImageView               *rightImageView;
@property (nonatomic ,strong) UIPageControl             *pageControl;

@property (nonatomic ,assign) CGFloat                    scrollWidth;
@property (nonatomic ,assign) CGFloat                    scrollHeight;

@property (nonatomic ,retain) NSArray                   *imagesArr;
@property (nonatomic ,retain) NSArray                   *messageArr;
@property (nonatomic ,assign) NSInteger                  imageNum;          //图片个数
@property (nonatomic ,assign) NSInteger                  currentIndex;      //当前状态下标
@property (nonatomic ,strong) NSTimer                    *timer; // 定时器

@property (nonatomic ,strong) UILabel                  *leftmessageLabel;
@property (nonatomic ,strong) UILabel                  *middlemessageLabel;
@property (nonatomic ,strong) UILabel                  *rightmessageLabel;

@end

@implementation ZXYScrollView


- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        _scrollWidth = frame.size.width;
        _scrollHeight = frame.size.height;
        
        self.isPageControl = YES;
        self.isMessageLabel = YES;
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _scrollWidth, _scrollHeight)];
        
        [self addScrollView];
        
        [self addImageViews];
        
        [self addTimer];
        
    }
    
    
    return self;
}


- (void)setUpViewWithImageUrls:(NSArray *)aUrls imgage:(NSArray *)aMessage
{
    if (self.isPageControl) [self addPageControl];
    
    if (self.isMessageLabel) [self addMessageLabel];
    
    _currentIndex = 0;
    _imagesArr = aUrls;
    _messageArr = aMessage;
    _imageNum = [_imagesArr count];
    
    
    if (aUrls.count == 1) {
        
        if ([[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"https://"]) {
            
            [self.middleImageView sd_setImageWithURL:[_imagesArr objectAtIndex:_currentIndex]];
            
        }else{
            self.middleImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:_currentIndex]];
        }
        
        if (@available(iOS 6.0, *)) {
            self.middlemessageLabel.text = _messageArr[_currentIndex];
        } else {
            // Fallback on earlier versions
        }
        self.mainScrollView.scrollEnabled = NO;
        [self.timer invalidate];
        
        return;
    }
    
    if ([[_imagesArr objectAtIndex:_imageNum-1] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:_imageNum-1] hasPrefix:@"https://"]) {
        
        [self.leftImageView sd_setImageWithURL:[_imagesArr objectAtIndex:_imageNum-1]];
        
    }else{
        self.leftImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:_imageNum-1]];
        
    }
    if ([[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"https://"]) {
        
        [self.middleImageView sd_setImageWithURL:[_imagesArr objectAtIndex:_currentIndex]];
        
    }else{
        self.middleImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:_currentIndex]];
        
    }
    
    if ([[_imagesArr objectAtIndex:_currentIndex+1] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:_currentIndex+1] hasPrefix:@"https://"]) {
        
        [self.rightImageView sd_setImageWithURL:[_imagesArr objectAtIndex:_currentIndex+1]];
        
    }else{
        self.rightImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:_currentIndex+1]];
        
    }
    
    
    
    if (@available(iOS 6.0, *)) {
        self.leftmessageLabel.text = _messageArr[_imageNum-1];
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 6.0, *)) {
        self.middlemessageLabel.text = _messageArr[_currentIndex];
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 6.0, *)) {
        self.rightmessageLabel.text = _messageArr[_currentIndex+1];
    } else {
        // Fallback on earlier versions
    }
    
    self.pageControl.currentPage = _currentIndex;
    self.pageControl.numberOfPages = _imageNum;
    
}

#pragma mark 添加控件
- (void)addScrollView{
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO; //  设置是否有边界
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(_scrollWidth * 3, 0);
    self.mainScrollView.contentOffset = CGPointMake(_scrollWidth, 0);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.mainScrollView];
    
}

#pragma mark 添加图片三个控件
- (void)addImageViews{
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollWidth, _scrollHeight)];
    self.leftImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollWidth, 0, _scrollWidth, _scrollHeight)];
    self.middleImageView.userInteractionEnabled = YES;
    self.middleImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollWidth * 2, 0, _scrollWidth, _scrollHeight)];
    self.rightImageView.contentMode = UIViewContentModeScaleToFill;
    
    //添加点击事件
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.middleImageView addGestureRecognizer:singleRecognizer];
    
    [self.mainScrollView addSubview:self.leftImageView];
    [self.mainScrollView addSubview:self.middleImageView];
    [self.mainScrollView addSubview:self.rightImageView];
    
}

#pragma mark 添加分页控件
- (void)addPageControl{
    
    self.pageControl = [[UIPageControl alloc]init];
    
    CGSize size= [_pageControl sizeForNumberOfPages:_imageNum];
    
    self.pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    self.pageControl.center = CGPointMake(_scrollWidth/2, _scrollHeight - 10);
    
    //    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_scrollWidth/2-100, _scrollHeight - 20, 200, 20)];
    
    [self addSubview:self.pageControl];
    
}

#pragma mark 添加信息控件
- (void)addMessageLabel{
    
    self.leftmessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _scrollHeight - 50, _scrollWidth, 30)];
    if (@available(iOS 6.0, *)) {
        self.leftmessageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // Fallback on earlier versions
    }
    
    
    self.middlemessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(_scrollWidth, _scrollHeight - 50, _scrollWidth, 30)];
    if (@available(iOS 6.0, *)) {
        self.middlemessageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // Fallback on earlier versions
    }
    
    
    self.rightmessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(_scrollWidth * 2, _scrollHeight - 50, _scrollWidth, 30)];
    if (@available(iOS 6.0, *)) {
        self.rightmessageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // Fallback on earlier versions
    }
    
    
    [self.mainScrollView addSubview:self.leftmessageLabel];
    [self.mainScrollView addSubview:self.middlemessageLabel];
    [self.mainScrollView addSubview:self.rightmessageLabel];
}

#pragma mark 添加定时器
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextNews) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextNews{
    
    [_mainScrollView setContentOffset:CGPointMake(_scrollWidth*2, 0) animated:YES];
    
}

- (void)upDateImageAndContentOffset
{
    self.pageControl.currentPage = _currentIndex;
    
    self.mainScrollView.contentOffset = CGPointMake(_scrollWidth, 0);
    
    if ([[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:_currentIndex] hasPrefix:@"https://"]) {
        
        [_middleImageView sd_setImageWithURL:[_imagesArr objectAtIndex:_currentIndex]];
        
    }else{
        _middleImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:_currentIndex]];
        
    }
    if ([[_imagesArr objectAtIndex:( _currentIndex + _imagesArr.count - 1 ) %_imagesArr.count] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:( _currentIndex + _imagesArr.count - 1 ) %_imagesArr.count] hasPrefix:@"https://"]) {
        
        [_leftImageView sd_setImageWithURL:[_imagesArr objectAtIndex:( _currentIndex + _imagesArr.count - 1 ) %_imagesArr.count]];
        
    }else{
        _leftImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:( _currentIndex + _imagesArr.count - 1 ) %_imagesArr.count]];
        
    }
    
    if ([[_imagesArr objectAtIndex:( _currentIndex + 1 ) %_imagesArr.count] hasPrefix:@"http://"] || [[_imagesArr objectAtIndex:( _currentIndex + 1 ) %_imagesArr.count] hasPrefix:@"https://"]) {
        
        [_rightImageView sd_setImageWithURL:[_imagesArr objectAtIndex:( _currentIndex + 1 ) %_imagesArr.count]];
        
    }else{
        _rightImageView.image = [UIImage imageNamed:[_imagesArr objectAtIndex:( _currentIndex + 1 ) %_imagesArr.count]];
        
    }
    
    if(_currentIndex == 0){
        
        if (@available(iOS 6.0, *)) {
            self.leftmessageLabel.text = _messageArr[_imageNum - 1];
        } else {
            // Fallback on earlier versions
        }
        
    }else{
        
        if (@available(iOS 6.0, *)) {
            self.leftmessageLabel.text = _messageArr[_currentIndex - 1];
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    if (@available(iOS 6.0, *)) {
        self.middlemessageLabel.text = _messageArr[( _currentIndex + _imagesArr.count ) %_imagesArr.count];
    } else {
        // Fallback on earlier versions
    }if (@available(iOS 6.0, *)) {
        self.middlemessageLabel.text = _messageArr[( _currentIndex + _imagesArr.count ) %_imagesArr.count];
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 6.0, *)) {
        self.rightmessageLabel.text = _messageArr[( _currentIndex + 1) %_imagesArr.count];
    } else {
        // Fallback on earlier versions
    }
    
}


#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(scrollView.contentOffset.x == 0)
    {
        //每次左滑下标-1.
        _currentIndex--;
        //当到达第一张的时候
        if(_currentIndex < 0)
        {
            _currentIndex = _imageNum - 1;
        }
        
        [self upDateImageAndContentOffset];
        
    }
    
    
    if(scrollView.contentOffset.x == _scrollWidth * 2)
    {
        //每次又滑下标+1.
        _currentIndex++;
        //当到达最后一张的时候
        if(_currentIndex == _imageNum)
        {
            _currentIndex = 0;
        }
        [self upDateImageAndContentOffset];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //    NSLog(@"正在拖拽视图，所以需要将自动播放暂停掉");
    //    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"开启定时器");
    [self.timer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
    
}

- (void)clickImage{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(successClickDelegate:)]) {
        
        [self.delegate successClickDelegate:_currentIndex];
    }
}

@end
