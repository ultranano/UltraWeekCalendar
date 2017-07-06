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
    UltraWeekCalendar *calendarExample01;
    UltraWeekCalendar *calendarExample02;
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
    
    //First Example
    calendarExample01 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, labelTest.frame.origin.y+labelTest.frame.size.height+10, self.view.frame.size.width, 55)];
    calendarExample01.delegate = self;
    calendarExample01.backgroundColor = UIColorFromRGB(0xCCCCCC);
    calendarExample01.monthTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample01.monthBGColor = UIColorFromRGB(0x7baecb);
    calendarExample01.dayNameTextColor = UIColorFromRGB(0x626262);
    calendarExample01.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendarExample01.dayScrollBGColor = UIColorFromRGB(0xFFFFFF);
    calendarExample01.dayNameSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample01.dayNumberSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample01.daySelectedBGColor = UIColorFromRGB(0x7baecb);
    calendarExample01.startDate = today;
    calendarExample01.endDate = nextDate;
    [self.view addSubview:calendarExample01];
    
    //Second Example
    calendarExample02 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, calendarExample01.frame.origin.y+calendarExample01.frame.size.height+10, self.view.frame.size.width, 155)];
    calendarExample02.delegate = self;
    calendarExample02.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    calendarExample02.backgroundColor = UIColorFromRGB(0xFFFFFF);
    calendarExample02.monthTextColor = UIColorFromRGB(0xCCCCCC);
    calendarExample02.monthBGColor = UIColorFromRGB(0xe54848);
    calendarExample02.dayNameTextColor = UIColorFromRGB(0x626262);
    calendarExample02.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendarExample02.dayScrollBGColor = UIColorFromRGB(0xCCCCCC);
    calendarExample02.dayNameSelectedTextColor = UIColorFromRGB(0xCCCCCC);
    calendarExample02.dayNumberSelectedTextColor = UIColorFromRGB(0xCCCCCC);
    calendarExample02.daySelectedBGColor = UIColorFromRGB(0xe54848);
    calendarExample02.startDate = today;
    calendarExample02.endDate = nextDate;
    [self.view addSubview:calendarExample02];
    
    labelDateTest = [[UILabel alloc] initWithFrame:CGRectMake(0, calendarExample02.frame.origin.y+calendarExample02.frame.size.height+30, self.view.frame.size.width, 80)];
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
    NSString *selectedDayStr = [df stringFromDate:calendarExample01.selectedDate];
    [labelDateTest setText:[NSString stringWithFormat:@"%@", selectedDayStr]];
}

@end
