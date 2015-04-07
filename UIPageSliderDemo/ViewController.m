//
//  ViewController.m
//  UIPageSliderDemo
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "ViewController.h"
#import "UIPageSlider.h"
#import "UIColor+CustomColor.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController () <UIPageSliderDataSource, UIPageSliderDelegate> {
  NSUInteger totalPagesCount;
}
@property(weak, nonatomic) IBOutlet UILabel *currentPageIndexLabel;
@property(nonatomic, strong) UIPageSlider *pageSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  totalPagesCount = 6;

  _pageSlider =
      [[UIPageSlider alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 48)
                           withDataSource:self
                             withDelegate:self];
  _pageSlider.backgroundColor = UIColorFromRGB(0xFAFAFA);
  [self.view addSubview:_pageSlider];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [_pageSlider scrollToPage:0 withAnimation:NO];
}

#pragma mark - UIPageSlider DataSource
- (NSUInteger)numberOfPagesInPageSlider:(UIPageSlider *)pageSlider {
  return totalPagesCount;
}

#pragma mark - UIPageSlider Delegate
- (void)pageSlider:(UIPageSlider *)pageSlider
    willScrollToPage:(NSUInteger)pageIndex {
}

- (void)pageSlider:(UIPageSlider *)pageSlider
    didScrollToPage:(NSUInteger)pageIndex {
  self.title =
      [NSString stringWithFormat:@"%lu/%lu", (pageIndex + 1), totalPagesCount];

  _currentPageIndexLabel.text =
      [NSString stringWithFormat:@"Current Page Index: %lu",
                                 _pageSlider.currentPageIndex];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
