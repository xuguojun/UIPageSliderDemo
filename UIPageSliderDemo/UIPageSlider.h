//
//  UIPageSlider.h
//  UIPageSlider
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIPageSlider;

#pragma mark - @protocol
@protocol UIPageSliderDataSource <NSObject>

@required
- (NSUInteger)numberOfPagesInPageSlider:(UIPageSlider *)pageSlider;

@end

@protocol UIPageSliderDelegate <NSObject>

- (void)pageSlider:(UIPageSlider *)pageSlider
    willScrollToPage:(NSUInteger)pageIndex;
- (void)pageSlider:(UIPageSlider *)pageSlider
    didScrollToPage:(NSUInteger)pageIndex;

@end

#pragma mark - @interface
@interface UIPageSlider : UIView

@property(nonatomic, weak) id<UIPageSliderDataSource> dataSource;
@property(nonatomic, weak) id<UIPageSliderDelegate> delegate;

@property(nonatomic, assign, readonly) NSUInteger currentPageIndex;

- (instancetype)initWithFrame:(CGRect)frame
               withDataSource:(id<UIPageSliderDataSource>)dataSource
                 withDelegate:(id<UIPageSliderDelegate>)delegate;
- (void)scrollToPage:(NSUInteger)pageIndex withAnimation:(BOOL)animated;

@end
