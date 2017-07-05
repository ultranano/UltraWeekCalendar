//
//  UltraViewController.m
//  UltraWeekCalendar
//
//  Created by Andrea Baldon on 07/04/2017.
//  Copyright (c) 2017 Andrea Baldon. All rights reserved.
//

#import "UltraViewController.h"

@interface UltraViewController ()

@end

@implementation UltraViewController
{
    UILabel *labelDateTest;
    NSDateFormatter *df;
    UltraWeekCalendar *calendar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *labelTest = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 80)];
    [labelTest setTextColor:UIColorFromRGB(0x232323)];
    [labelTest setTextAlignment:NSTextAlignmentCenter];
    [labelTest setText:@"UltraWeekCalendar Demo"];
    [self.view addSubview:labelTest];
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:6];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
    calendar = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, labelTest.frame.origin.y+labelTest.frame.size.height+10, self.view.frame.size.width, 55)];
    calendar.delegate = self;
    calendar.backgroundColor = UIColorFromRGB(0xCCCCCC);
    calendar.monthTextColor = UIColorFromRGB(0xFFFFFF);
    calendar.monthBGColor = UIColorFromRGB(0x7baecb);
    calendar.dayNameTextColor = UIColorFromRGB(0x626262);
    calendar.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendar.dayScrollBGColor = UIColorFromRGB(0xFFFFFF);
    calendar.dayNameSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendar.dayNumberSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendar.daySelectedBGColor = UIColorFromRGB(0x7baecb);
    calendar.startDate = today;
    calendar.endDate = nextDate;
    [self.view addSubview:calendar];
    
    labelDateTest = [[UILabel alloc] initWithFrame:CGRectMake(0, calendar.frame.origin.y+calendar.frame.size.height+30, self.view.frame.size.width, 80)];
    [labelDateTest setBackgroundColor:UIColorFromRGB(0xCCCCCC)];
    [labelDateTest setTextColor:UIColorFromRGB(0xFFFFFF)];
    [labelDateTest setTextAlignment:NSTextAlignmentCenter];
    df = [[NSDateFormatter alloc] init];
    df.dateFormat=@"dd-MM-yyyy";
    [self.view addSubview:labelDateTest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UltraWeekCalendar Delegate Methods

- (void)dateButtonClicked
{
    NSLog(@"dateButtonClicked");
    NSString *selectedDayStr = [df stringFromDate:calendar.selectedDate];
    [labelDateTest setText:[NSString stringWithFormat:@"%@", selectedDayStr]];
}

@end
