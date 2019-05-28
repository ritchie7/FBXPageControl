//
//  FBXPageControl.m
//  chinese
//
//  Created by ritchie on 2019/5/24.
//  Copyright © 2019 ritchie. All rights reserved.
//

#import "FBXPageControl.h"


@implementation FBXPageControlConfig
- (instancetype)init
{
    self = [super init];
    if ( self ) {
        [self initialize];
    }
    return self;
}

- (void)initialize{}
@end

@implementation FBXPageControlConfigNormal
@end


@interface FBXPageControl ()
@property (nonatomic, strong) NSMutableArray<UIView *> *pool;
@end

@implementation FBXPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    
    _pool = [NSMutableArray array];
    self.backgroundColor = [UIColor clearColor];
    
//    self.layer.cornerRadius
    _currentPage = 0;
    _numberOfPages = 0;
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
//    _config = [[FBXPageControlConfig alloc] init];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    if (numberOfPages < 1) return;
    
    NSMutableArray *tmp = _pool.mutableCopy;
    for (int i = 0; i < numberOfPages - tmp.count; i++) {
        
        UIView *control = [[UIView alloc] init];
        
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [control addGestureRecognizer:tapGesture];
        
        [self addSubview:control];
        [_pool addObject:control];
    }
    
    if (numberOfPages < tmp.count) // remove excess.
    {
        for (int i = 0; i < tmp.count - numberOfPages ; i++) {
            [_pool removeObjectAtIndex:0];
        }
    }
    
    [self updateControls];
    
    
//    if ([self.delegate respondsToSelector:@selector(pageControl:controlViews:)] && _numberOfPages > 0)
//    {
//        [self.delegate pageControl:self controlViews:_pool];
//    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    NSInteger oldCurrentPage = _currentPage;
    _currentPage = currentPage;
    
    if (oldCurrentPage == currentPage) return;
    
//    NSAssert(_currentPage >= _pool.count, @"Could not find constraint %@", constraint);
    
    if (_currentPage >= _pool.count || oldCurrentPage >= _pool.count) return;
    
    NSLog(@"---------%li", currentPage);
    
    if (oldCurrentPage < _currentPage) { // ➡️
        for (NSInteger i = oldCurrentPage; i < _currentPage; i++) {
            
            [self exchangeControl:i to:i+1];
        }
    } else { // ⬅️
        for (NSInteger i = oldCurrentPage; i > _currentPage; i--) {
            [self exchangeControl:i to:i-1];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(pageControl:didSelectedControl:to:)])
    {
        [self.delegate pageControl:self didSelectedControl:oldCurrentPage to:currentPage];
    }
//    if ([self.delegate respondsToSelector:@selector(pageControl:didSelectedControl:to:controlViews:)])
//    {
//        [self.delegate pageControl:self didSelectedControl:oldCurrentPage to:currentPage controlViews:_pool];
//    }
}


- (void)setControlSize:(CGSize)controlSize
{
    _controlSize = controlSize;
    [self updateControls];
}

- (void)setCurrentControlSize:(CGSize)currentControlSize
{
    _currentControlSize = currentControlSize;
    [self updateControls];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self updateControls];
}

- (void)setCurrentCornerRadius:(CGFloat)currentCornerRadius
{
    _currentCornerRadius = currentCornerRadius;
    [self updateControls];
}

- (void)setCurrentControlAlpha:(CGFloat)currentControlAlpha
{
    _currentControlAlpha = currentControlAlpha;
    [self updateControls];
}

- (void)setNormalControlAlpha:(CGFloat)normalControlAlpha
{
    _normalControlAlpha = normalControlAlpha;
    [self updateControls];
}

- (void)setAlignment:(FBXPageControlAlignment)alignment
{
    _alignment = alignment;
    if (alignment > FBXPageControlAlignmentBottom || alignment < FBXPageControlAlignmentTop) _alignment = FBXPageControlAlignmentCenter;
    [self updateControls];
}

- (void)setStyle:(FBXPageControlStyle)style
{
    _style = style;
    if (style > FBXPageControlStyleMoved || style < FBXPageControlStyleNormal) _style = FBXPageControlStyleNormal;
}

- (void)setDelegate:(id<FBXPageControlDelegate>)delegate
{
    _delegate = delegate;
//    if ([self.delegate respondsToSelector:@selector(pageControl:controlViews:)] && _numberOfPages > 0)
//    {
//        [self.delegate pageControl:self controlViews:_pool];
//    }
}


- (void)updateControls
{
    for (int i = 0; i < _numberOfPages; i++) {
        
        UIView *control = _pool[i];
        
        control.alpha = self.normalControlAlpha;
        control.layer.cornerRadius = self.cornerRadius;
        control.backgroundColor = self.pageIndicatorTintColor;
        
        CGSize size = self.controlSize;
        
        CGFloat y = 0;
        CGFloat x = 0;
        
        if (i > 0) x = CGRectGetMaxX(_pool[i-1].frame) + self.controlSpacing;
        
        
        if (self.alignment == FBXPageControlAlignmentTop) y = 0;
        else if (self.alignment == FBXPageControlAlignmentCenter)
        {
            y = fabs(self.controlSize.height - self.currentControlSize.height) / 2.f;
            
            if (self.currentControlSize.height < self.controlSize.height)
            {
                if (i != self.currentPage) y = 0;
            } else
            {
                if (i == self.currentPage) y = 0;
            }
        }
        else if (self.alignment == FBXPageControlAlignmentBottom)
        {
            y = fabs(self.controlSize.height - self.currentControlSize.height);
            if (self.currentControlSize.height < self.controlSize.height)
            {
                if (i != self.currentPage) y = 0;
            } else
            {
                if (i == self.currentPage) y = 0;
            }
        }
        
        if (i == self.currentPage)
        {
            size = self.currentControlSize;
            control.alpha = self.currentControlAlpha;
            control.layer.cornerRadius = self.currentCornerRadius;
            control.backgroundColor = self.currentPageIndicatorTintColor;
        }
        control.frame = (CGRect){x, y, size};
    }
}

- (void)exchangeControl:(NSInteger)from to:(NSInteger)to
{
    if (self.style == FBXPageControlStyleMoved)
    {
        [_pool exchangeObjectAtIndex:from withObjectAtIndex:to];
    }
    UIView *fromControl = _pool[from];
    UIView *toControl = _pool[to];
    
    [self bringSubviewToFront:toControl];
    
    
    CGRect fromFrame = fromControl.frame;
    CGRect toFrame = toControl.frame;

    
    [UIView animateWithDuration:_anmationDuration animations:^{
        
        if (from > to) // ⬅️
        {
            if (self.style == FBXPageControlStyleNormal)
            {
                toControl.frame = (CGRect){CGRectGetMinX(toFrame), CGRectGetMinY(fromFrame), self.currentControlSize};
                fromControl.frame = (CGRect){CGRectGetMaxX(toControl.frame)+self.controlSpacing, CGRectGetMinY(toFrame), self.controlSize};
            } else
            {
                toControl.frame = (CGRect){CGRectGetMinX(fromFrame), CGRectGetMinY(toFrame), toFrame.size};
                fromControl.frame = (CGRect){CGRectGetMaxX(toControl.frame) + self.controlSpacing, CGRectGetMinY(fromFrame), fromFrame.size};
            }
            
        }
        else // ➡️
        {
            if (self.style == FBXPageControlStyleNormal)
            {
                fromControl.frame = (CGRect){CGRectGetMinX(fromFrame), CGRectGetMinY(toFrame), self.controlSize};
                toControl.frame = (CGRect){CGRectGetMaxX(fromControl.frame) + self.controlSpacing, CGRectGetMinY(fromFrame), self.currentControlSize};
            } else
            {
                fromControl.frame = (CGRect){CGRectGetMinX(toFrame), CGRectGetMinY(fromFrame), fromFrame.size};
                toControl.frame = (CGRect){CGRectGetMaxX(fromControl.frame) + self.controlSpacing, CGRectGetMinY(toFrame), toFrame.size};
            }
            
        }
        
        toControl.layer.cornerRadius = self.currentCornerRadius;
        fromControl.layer.cornerRadius = self.cornerRadius;
        
        toControl.alpha = self.currentControlAlpha;
        fromControl.alpha = self.normalControlAlpha;
    }];
    
    if (self.colorTransition)
    {
        [UIView animateWithDuration:self.colorTransition animations:^{
            toControl.backgroundColor = self.currentPageIndicatorTintColor;
            fromControl.backgroundColor = self.pageIndicatorTintColor;
        }];
        
    } else {
//        NSTextAlignment
        toControl.backgroundColor = _currentPageIndicatorTintColor;
        fromControl.backgroundColor = _pageIndicatorTintColor;
    }
}


- (void)clickAction:(UITapGestureRecognizer *)recognizer {
    
//    return;
    UIView *control = recognizer.view;
    NSInteger page = [_pool indexOfObject:control];
    self.currentPage = page;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGFloat height = _currentControlSize.height > _controlSize.height ? _currentControlSize.height : _controlSize.height;
    CGFloat width = CGRectGetMaxX(_pool.lastObject.frame);
    self.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), width, height);
    
}

@end
