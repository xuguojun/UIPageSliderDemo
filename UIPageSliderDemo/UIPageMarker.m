//
//  UIPageMarker.m
//  UIPageSlider
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import "UIPageMarker.h"
#import "UIColor+CustomColor.h"

static const CGFloat STROKE_WIDTH = 0.6f;
static const CGFloat CIRCLE_RADIUS = 18.0f;

@interface UIPageMarker ()

@property(nonatomic, assign, readwrite) NSUInteger pageNumber;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation UIPageMarker

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    self = [self initWithFrame:frame withPageNumber:0];
  }

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
               withPageNumber:(NSUInteger)pageNumber {
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = [UIColor clearColor];
    self.pageNumber = pageNumber;

    [self addTitleLabel:[self stringFrom:pageNumber]];
  }

  return self;
}

- (void)addTitleLabel:(NSString *)text {
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  titleLabel.text = text;
  titleLabel.textColor = [UIColor whiteColor];

  self.titleLabel = titleLabel;
  [self addSubview:titleLabel];
}

- (void)changePageIndexTo:(NSUInteger)pageIndex {
  self.titleLabel.text = [self stringFrom:pageIndex];
}

- (NSString *)stringFrom:(NSUInteger)pageIndex {
  NSString *text =
      [NSString stringWithFormat:@"%lu", (unsigned long)(pageIndex + 1)];
  return text;
}

- (void)drawRect:(CGRect)rect {

  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSaveGState(context);

  {
    UIColor *strokeColor = UIColorFromRGB(0xD8D8D8);
    UIColor *fillColor = UIColorFromRGB(0xF94747);

    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, STROKE_WIDTH);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);

    CGFloat rectWidth = sqrtf(2) * (CIRCLE_RADIUS - STROKE_WIDTH);
    CGFloat rectHeight = rectWidth;
    CGFloat rectX = (CGRectGetWidth(self.bounds) / 2) - (rectWidth / 2);
    CGFloat rectY = rectX;

    rect = CGRectMake(rectX, rectY, rectWidth, rectHeight);
    CGContextStrokeEllipseInRect(context, rect);

    CGSize offset = CGSizeMake(0, 2.0);
    CGContextSetShadow(context, offset, 4.0);

    CGContextFillEllipseInRect(context, rect);
  }

  CGContextRestoreGState(context);
}

@end
