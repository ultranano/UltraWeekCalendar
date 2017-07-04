//
//  UltraWeekCalendar.h
//  Pods
//
//  Created by Andrea Baldon on 04/07/2017.
//
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UltraWeekCalendar : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) UIColor *monthBGColor;
@property (nonatomic, strong) UIColor *dayScrollBGColor;
@property (nonatomic, assign) CGFloat lastContentOffset;

@end
