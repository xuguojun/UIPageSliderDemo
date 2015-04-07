//
//  UIPageMarker.h
//  UIPageSlider
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageMarker : UIControl

@property(nonatomic, assign, readonly) NSUInteger pageNumber;

- (instancetype)initWithFrame:(CGRect)frame
               withPageNumber:(NSUInteger)pageNumber;
- (void)changePageIndexTo:(NSUInteger)pageIndex;

@end
