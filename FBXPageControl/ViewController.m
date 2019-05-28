//
//  ViewController.m
//  FBXPageControl
//
//  Created by ritchie on 2019/5/28.
//  Copyright © 2019 ritchie. All rights reserved.
//

#import "ViewController.h"
#import "FBXPageControl.h"

#define KCOLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1]

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, FBXPageControlDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) FBXPageControl *pageControl1;
@property (nonatomic, strong) FBXPageControl *pageControl2;
@property (nonatomic, strong) FBXPageControl *pageControl3;
@property (nonatomic, strong) FBXPageControl *pageControl4;
@property (nonatomic, strong) FBXPageControl *pageControl5;
@property (nonatomic, strong) FBXPageControl *pageControl6;
@property (nonatomic, strong) FBXPageControl *pageControl7;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    /**
     _controlSpacing = 10.f;
     _controlSize = CGSizeMake(5, 30);
     _currentControlSize = CGSizeMake(5, 50);
     
     _cornerRadius = 0.f;
     _currentCornerRadius = 0.f;
     
     _normalControlAlpha = 1.f;
     _currentControlAlpha = 1.f;
     
     _anmationDuration = 1.f;
     
     _pageIndicatorTintColor = [UIColor grayColor];
     _currentPageIndicatorTintColor = [UIColor redColor];
     
     _colorTransition = NO;
     
     _style = FBXPageControlStyleNormal;
     _alignment = FBXPageControlAlignmentCenter;
     */
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    _pageControl1 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 250, width, 30)];
    _pageControl1.numberOfPages = 10;
    _pageControl1.controlSize = CGSizeMake(10, 10);
    _pageControl1.currentControlSize = CGSizeMake(10, 10);
    _pageControl1.cornerRadius = 5;
    _pageControl1.currentControlAlpha = .5;
    _pageControl1.currentCornerRadius = 5;
    [self.view addSubview:_pageControl1];
    
    _pageControl2 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 300, width, 30)];
    _pageControl2.numberOfPages = 10;
    _pageControl2.controlSize = CGSizeMake(10, 10);
    _pageControl2.currentControlSize = CGSizeMake(20, 10);
    _pageControl2.cornerRadius = 5;
    _pageControl2.currentCornerRadius = 5;
    _pageControl2.colorTransition = YES;
    [self.view addSubview:_pageControl2];
    
    _pageControl3 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 350, width, 30)];
    _pageControl3.numberOfPages = 10;
//    _pageControl3.con
    _pageControl3.controlSize = CGSizeMake(5, 10);
    _pageControl3.currentControlSize = CGSizeMake(5, 20);
    _pageControl3.cornerRadius = 2.5;
    _pageControl3.currentCornerRadius = 2.5;
    [self.view addSubview:_pageControl3];
    
    _pageControl4 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 400, width, 30)];
    _pageControl4.numberOfPages = 10;
    _pageControl4.controlSize = CGSizeMake(5, 10);
    _pageControl4.currentControlSize = CGSizeMake(5, 20);
    _pageControl4.cornerRadius = 2.5;
    _pageControl4.currentCornerRadius = 2.5;
    _pageControl4.alignment = FBXPageControlAlignmentTop;
    [self.view addSubview:_pageControl4];
    
    _pageControl5 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 450, width, 30)];
    _pageControl5.numberOfPages = 10;
    _pageControl5.controlSize = CGSizeMake(5, 10);
    _pageControl5.currentControlSize = CGSizeMake(5, 20);
    _pageControl5.cornerRadius = 2.5;
    _pageControl5.currentCornerRadius = 2.5;
    _pageControl5.alignment = FBXPageControlAlignmentBottom;
    _pageControl5.style = FBXPageControlStyleMoved;
    [self.view addSubview:_pageControl5];
    
    _pageControl6 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 500, width, 30)];
    _pageControl6.numberOfPages = 10;
    _pageControl6.controlSize = CGSizeMake(10, 10);
    _pageControl6.currentControlSize = CGSizeMake(20, 20);
    _pageControl6.cornerRadius = 5;
    _pageControl6.currentCornerRadius = 10;
    _pageControl6.alignment = FBXPageControlAlignmentBottom;
    _pageControl6.style = FBXPageControlStyleMoved;
    [self.view addSubview:_pageControl6];
    
    _pageControl7 = [[FBXPageControl alloc] initWithFrame:CGRectMake(50, 550, width, 30)];
    _pageControl7.numberOfPages = 10;
    _pageControl7.controlSize = CGSizeMake(10, 10);
    _pageControl7.currentControlSize = CGSizeMake(20, 20);
    _pageControl7.cornerRadius = 5;
    _pageControl7.currentCornerRadius = 2.5;
    _pageControl7.alignment = FBXPageControlAlignmentCenter;
//    _pageControl7.style = FBXPageControlStyleMoved;
    [self.view addSubview:_pageControl7];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = KCOLOR_RANDOM;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    _pageControl1.currentPage = currentPage;
    _pageControl2.currentPage = currentPage;
    _pageControl3.currentPage = currentPage;
    _pageControl4.currentPage = currentPage;
    _pageControl5.currentPage = currentPage;
    _pageControl6.currentPage = currentPage;
    _pageControl7.currentPage = currentPage;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat height = 200.f;
        CGFloat width = CGRectGetWidth(self.view.bounds);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(width, height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

@end
