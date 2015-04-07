//
//  UIPageSlider.m
//  UIPageSlider
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "UIPageSlider.h"
#import "UIPageMarker.h"

static const CGFloat STROKE_WIDTH = 3.0f;
static const CGFloat DOT_WIDTH = 2.8f;

static const NSTimeInterval ScrollAnimationDuration = 0.4f;
static const NSTimeInterval ScrollAnimationZeroDuration = 0.0f;

@interface UIPageSlider () {
  NSUInteger numberOfPages;
}

@property(nonatomic, strong) UIPageMarker *markView;
@property(nonatomic, assign, readwrite) NSUInteger currentPageIndex;

@end

@implementation UIPageSlider

- (instancetype)initWithFrame:(CGRect)frame
               withDataSource:(id<UIPageSliderDataSource>)dataSource
                 withDelegate:(id<UIPageSliderDelegate>)delegate {
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;

    self.dataSource = dataSource;
    self.delegate = delegate;

    numberOfPages = [self.dataSource numberOfPagesInPageSlider:self];
    self.currentPageIndex = 0;

    [self setTouchGesture];
    [self addPageMarkView];
    [self setTouchGestureForPageMarker];
  }

  return self;
}

- (void)setTouchGesture {
  UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
  [gesture addTarget:self action:@selector(pageSliderDidTap:)];

  [self addGestureRecognizer:gesture];
}

- (void)setTouchGestureForPageMarker {
  [self.markView addTarget:self
                    action:@selector(pageMarkerMove:withEvent:)
          forControlEvents:UIControlEventTouchDragInside |
                           UIControlEventTouchDragOutside |
                           UIControlEventValueChanged];

  [self.markView addTarget:self
                    action:@selector(pageMarkerDidTouchUp:withEvent:)
          forControlEvents:UIControlEventTouchUpInside |
                           UIControlEventTouchUpOutside];
}

- (void)pageMarkerMove:(UIPageMarker *)pageMarkView withEvent:(UIEvent *)event {
  CGPoint currentPoint = [[[event allTouches] anyObject] locationInView:self];

  CGFloat width = pageMarkView.frame.size.width;
  CGFloat height = pageMarkView.frame.size.height;
  CGFloat y = pageMarkView.frame.origin.y;

  [pageMarkView
      setFrame:CGRectMake(currentPoint.x - width / 2, y, width, height)];
}

- (void)pageMarkerDidTouchUp:(UIPageMarker *)pageMarkView
                   withEvent:(UIEvent *)event {
  CGPoint currentPoint = [[[event allTouches] anyObject] locationInView:self];

  NSUInteger pageIndex = [self pageIndexForTouchLocation:currentPoint];
  [self scrollToPage:pageIndex withAnimation:YES];
}

- (void)pageSliderDidTap:(UITapGestureRecognizer *)gesture {
  CGPoint location = [gesture locationInView:self];

  NSUInteger pageIndex = [self pageIndexForTouchLocation:location];
  [self scrollToPage:pageIndex withAnimation:YES];
}

- (NSUInteger)pageIndexForTouchLocation:(CGPoint)location {
  NSUInteger pageIndex = 0;

  CGFloat touchAreaDiameter = self.bounds.size.width / numberOfPages;
  pageIndex = floor(location.x / touchAreaDiameter);

  return pageIndex;
}

- (CGPoint)centerLocationForPageIndex:(NSUInteger)pageIndex {

  CGFloat touchAreaRadius = self.bounds.size.width / 2 / numberOfPages;

  CGFloat x = touchAreaRadius * (pageIndex * 2 + 1);
  CGFloat y = (self.bounds.size.height / 2);

  CGPoint centerLocation = CGPointMake(x, y);

  return centerLocation;
}

- (void)addPageMarkView {

  CGFloat markViewWidth = 44;
  CGFloat markViewHeight = markViewWidth;

  CGPoint defaultPoint = [self centerLocationForPageIndex:0];
  CGRect rect = CGRectMake(defaultPoint.x - markViewWidth / 2,
                           defaultPoint.y - markViewHeight / 2, markViewWidth,
                           markViewHeight);
  self.markView = [[UIPageMarker alloc] initWithFrame:rect];

  [self addSubview:self.markView];
}

- (void)scrollToPage:(NSUInteger)pageIndex withAnimation:(BOOL)animated {

  [self.delegate pageSlider:self willScrollToPage:pageIndex];

  CGPoint toPoint = [self centerLocationForPageIndex:pageIndex];

  CGFloat width = self.markView.frame.size.width;
  CGFloat height = self.markView.frame.size.height;

  self.userInteractionEnabled = NO;
  [UIView animateWithDuration:(animated ? ScrollAnimationDuration
                                        : ScrollAnimationZeroDuration)
      animations:^{
        [self.markView
            setFrame:CGRectMake(toPoint.x - width / 2, toPoint.y - height / 2,
                                width, height)];
      }
      completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        [self.markView changePageIndexTo:pageIndex];
        self.currentPageIndex = pageIndex;
        [self.delegate pageSlider:self didScrollToPage:pageIndex];
      }];
}

- (void)drawRect:(CGRect)rect {

  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSaveGState(context);

  CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
  CGContextSetLineWidth(context, STROKE_WIDTH);

  // drawing dots
  CGFloat x = 0.0f;
  CGFloat y = (self.bounds.size.height / 2) - (DOT_WIDTH / 2);
  CGFloat width = DOT_WIDTH;
  CGFloat height = width;

  CGFloat touchAreaRadius = self.bounds.size.width / 2 / numberOfPages;

  for (int i = 0; i < numberOfPages; i++) {

    x = touchAreaRadius * (i * 2 + 1) - DOT_WIDTH / 2;

    CGRect dotRect = CGRectMake(x, y, width, height);

    CGContextStrokeEllipseInRect(context, dotRect);
  }
}

@end
