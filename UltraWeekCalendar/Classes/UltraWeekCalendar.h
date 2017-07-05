//
//  UltraWeekCalendar.h
//  Pods
//
//  Created by Andrea Baldon on 04/07/2017.
//
//
#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@protocol UltraWeekCalendarDelegate <NSObject>
@optional
- (void)dateButtonClicked;
@end

@interface UltraWeekCalendar : UIView <UIScrollViewDelegate>
{
    id<UltraWeekCalendarDelegate> delegate;
}

@property (strong, nonatomic) id<UltraWeekCalendarDelegate> delegate;

//Init Params
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

//Style
@property (nonatomic, strong) UIColor *dayNumberTextColor;
@property (nonatomic, strong) UIColor *dayNameTextColor;
@property (nonatomic, strong) UIColor *monthTextColor;
@property (nonatomic, strong) UIColor *monthBGColor;
@property (nonatomic, strong) UIColor *dayScrollBGColor;
@property (nonatomic, strong) UIColor *dayNumberSelectedTextColor;
@property (nonatomic, strong) UIColor *dayNameSelectedTextColor;
@property (nonatomic, strong) UIColor *daySelectedBGColor;

//Values
@property (atomic, strong) NSDate *selectedDate;

@end
