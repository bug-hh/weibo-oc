//
//  NewFeatureViewController.m
//  weibo-oc
//
//  Created by bughh on 2020/7/9.
//  Copyright © 2020 bughh. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "UIButton+Convenience.h"

@interface NewFeatureCell : UICollectionViewCell

@property(strong, nonatomic) UIImageView* imageView;
@property(strong, nonatomic) UIButton* startButton;
@property(assign, nonatomic) NSInteger imageIndex;

@end

@implementation NewFeatureCell

#pragma mark - 懒加载控件
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] initWithTitle:@"" andColor:[UIColor whiteColor] andBgImageName:@"guideStart"];
    }
    return _startButton;
}

#pragma mark - 设置背景图片
- (void)setImageIndex:(NSInteger)imageIndex {
    _imageIndex = imageIndex;
    _imageView.image =  [UIImage imageNamed:[NSString stringWithFormat:@"guide%ldBackground", _imageIndex + 1]];
    _startButton.hidden = YES;
}

#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

#pragma mark - 设置布局
- (void)setupUI {
    [self addSubview:self.imageView];
    [self addSubview:self.startButton];
    
    self.imageView.frame = self.bounds;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *startButtonConX = [NSLayoutConstraint constraintWithItem:self.startButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:startButtonConX];
    
    
    NSLayoutConstraint *startButtonBottom = [NSLayoutConstraint constraintWithItem:self.startButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.8 constant:0];
    [self addConstraint:startButtonBottom];
    
    [self.startButton addTarget:self action:@selector(startButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma 显示「立即体验」按钮动画
- (void)showButtonAnimate {
    self.startButton.hidden = NO;
    self.startButton.transform = CGAffineTransformMakeScale(0, 0);
    [self.startButton setUserInteractionEnabled:NO];
   
    [UIView animateWithDuration:2.0        // 动画时长
                          delay:0          // 延迟时间
         usingSpringWithDamping:0.6        // 弹力系数，0-1，越小越弹
          initialSpringVelocity:10         // 模拟重力加速度
                        options:0          // 动画选项
                     animations:^{
        self.startButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.startButton setUserInteractionEnabled:YES];
    }];
}

#pragma mark 「开始体验」点击事件
- (void)startButtonClicked {
    NSLog(@"立即体验");
    [NSNotificationCenter.defaultCenter postNotificationName:WBSwitchRootViewControllerNotification object:nil];
}

@end


@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

static NSString * const WBNewFeatureCellID = @"WBNewFeatureCellID";
static int WBNewFeatureImageCount = 4;


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.collectionView.pagingEnabled = YES;
        self.collectionView.bounces = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:WBNewFeatureCellID];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WBNewFeatureImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewFeatureCell *cell = (NewFeatureCell*)[collectionView dequeueReusableCellWithReuseIdentifier:WBNewFeatureCellID forIndexPath:indexPath];
    cell.imageIndex = indexPath.item;
    return cell;
}

#pragma mark - 停止滚动代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page != WBNewFeatureImageCount - 1) {
        return;
    }
    // 如果滚到最后一页，就显示动画
    NewFeatureCell *cell = (NewFeatureCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0]];
    [cell showButtonAnimate];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
