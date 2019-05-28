//
//  FBXPageControl.h
//  chinese
//
//  Created by ritchie on 2019/5/24.
//  Copyright © 2019 ritchie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class FBXPageControl;
typedef NS_ENUM(NSUInteger, FBXPageControlStyle) {
    FBXPageControlStyleNormal = 0,
    FBXPageControlStyleMoved,
};

typedef NS_ENUM(NSUInteger, FBXPageControlAlignment) {
    FBXPageControlAlignmentTop = 0,
    FBXPageControlAlignmentCenter,
    FBXPageControlAlignmentBottom,
};

@protocol FBXPageControlDelegate <NSObject>

@optional

- (void)pageControl:(FBXPageControl *)pageControl didSelectedControl:(NSInteger)from to:(NSInteger)to; // when userinterface = YES.
@end

@interface FBXPageControl : UIControl

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic) CGFloat controlSpacing;
@property (nonatomic) CGSize controlSize;
@property (nonatomic) CGSize currentControlSize;

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat currentCornerRadius;
@property (nonatomic) CGFloat normalControlAlpha;
@property (nonatomic) CGFloat currentControlAlpha;

@property (nonatomic) CGFloat anmationDuration;

@property (nullable, nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nullable, nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, assign) BOOL colorTransition;

@property (nonatomic) FBXPageControlStyle style;
@property (nonatomic) FBXPageControlAlignment alignment;

@property (nonatomic, weak)  id <FBXPageControlDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
