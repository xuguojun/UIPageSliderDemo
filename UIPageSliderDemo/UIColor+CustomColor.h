//
//  UIColor+CustomColor.h
//  UIPageSliderView
//
//  Created by guojun on 4/7/15.
//  Copyright (c) 2015 kaikeba. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue)                                               \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
                   blue:((float)(rgbValue & 0xFF)) / 255.0                     \
                  alpha:1.0]

@interface UIColor (CustomColor)

@end
