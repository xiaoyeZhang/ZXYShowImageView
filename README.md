# ZXYShowImageView

# 使用ZXYShowImageView

三步完成主流App框架搭建：

 - 第一步：使用CocoaPods导入ZXYShowImageView
 - 第二步：设置ZXYShowImageView的两个数组：图片URL数组和图片信息数组,并将ZXYShowImageView加到view上
 - 第三步（可选）：隐藏PageControl和图片信息控件

# 第一步：使用CocoaPods导入ZXYShowImageView

CocoaPods 导入

CocoaPods 安装

  打开 Podfile，在您项目的 target 下加入以下内容。（在此以 v1.6.7 版本为例）

  在文件 Podfile 中加入以下内容：

    pod 'ZXYShowImageView'
  然后在终端中运行以下命令：

    pod install
  或者这个命令：
```
  禁止升级 CocoaPods 的 spec 仓库，否则会卡在 Analyzing dependencies，非常慢
    pod install --verbose --no-repo-update
  或者
    pod update --verbose --no-repo-update
```
  完成后，CocoaPods 会在您的工程根目录下生成一个 .xcworkspace 文件。您需要通过此文件打开您的工程，而不是之前的 .xcodeproj。

# 第二步：设置ZXYShowImageView的两个数组：图片URL数组和图片信息数组,并将ZXYShowImageView加到view上

```
    NSArray *arr = @[@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg",
                     @"http://img.zcool.cn/community/01f09e577b85450000012e7e182cf0.jpg",
                     @"http://img.zcool.cn/community/010f87596f13e6a8012193a363df45.jpg",
                     @"http://img.zcool.cn/community/018d4e554967920000019ae9df1533.jpg",
                     @"http://img.zcool.cn/community/010a1b554c01d1000001bf72a68b37.jpg",
                     @"http://pic.58pic.com/58pic/15/57/84/70H58PICCJt_1024.jpg"
                     ];
    NSArray *arr1 = @[@"第一张图",
                      @"第二张图",
                      @"第三张图",
                      @"第四张图",
                      @"第五张图",
                      @"第六张图"];
    
    ZXYScrollView *scrollView = [[ZXYScrollView alloc] initWithFrame:CGRectMake(0, BARFRAME_NAVBAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, 200)];
    scrollView.delegate = self;
    [scrollView setUpViewWithImageUrls:arr imgage:arr1];
    [self.view addSubview:scrollView];

```

# 第三步（可选）：隐藏PageControl和图片信息控件

  ```
     scrollView.isPageControl = YES; 默认都为YES，设为NO隐藏控件
     scrollView.isMessageLabel = YES;
``` 
# 实现代理方法
   获取点击的图片的id

  ```
     - (void)successClickDelegate:(NSInteger)num{


        NSLog(@"----------%ld ---- %@",num,arr1[num]);
    }
  ```  
