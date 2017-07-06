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
    UltraWeekCalendar *calendarExample03;
    UltraWeekCalendar *calendarExample04;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *labelTest = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 50)];
    [labelTest setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [labelTest setTextColor:UIColorFromRGB(0x232323)];
    [labelTest setTextAlignment:NSTextAlignmentCenter];
    [labelTest setText:@"UltraWeekCalendar Demo"];
    [self.view addSubview:labelTest];
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:6];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    [offsetComponents setMonth:3];
    NSDate *nextDate2 = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
    //First Basic Example with English Language
    calendarExample01 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, labelTest.frame.origin.y+labelTest.frame.size.height+10, self.view.frame.size.width, 55)];
    calendarExample01.delegate = self;
    calendarExample01.fixedMonthLabelWidth = 80;
    calendarExample01.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    calendarExample01.startDate = today;
    calendarExample01.endDate = nextDate;
    [self.view addSubview:calendarExample01];
    
    //Second Example on Current Locale
    calendarExample02 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, calendarExample01.frame.origin.y+calendarExample01.frame.size.height+10, self.view.frame.size.width, 100)];
    calendarExample02.delegate = self;
    calendarExample02.backgroundColor = UIColorFromRGB(0xCCCCCC);
    calendarExample02.monthTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample02.monthBGColor = UIColorFromRGB(0x7baecb);
    calendarExample02.dayNameTextColor = UIColorFromRGB(0x626262);
    calendarExample02.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendarExample02.dayScrollBGColor = UIColorFromRGB(0xFFFFFF);
    calendarExample02.dayNameSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample02.dayNumberSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample02.daySelectedBGColor = UIColorFromRGB(0x7baecb);
    calendarExample02.startDate = today;
    calendarExample02.endDate = nextDate;
    [self.view addSubview:calendarExample02];
    
    //Third Example with Arabic Language
    calendarExample03 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, calendarExample02.frame.origin.y+calendarExample02.frame.size.height+10, self.view.frame.size.width, 50)];
    calendarExample03.delegate = self;
    calendarExample03.fixedMonthLabelWidth = 65;
    calendarExample03.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_SA"];
    calendarExample03.backgroundColor = UIColorFromRGB(0xFFFFFF);
    calendarExample03.monthTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample03.monthBGColor = UIColorFromRGB(0xf085a0);
    calendarExample03.dayNameTextColor = UIColorFromRGB(0x626262);
    calendarExample03.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendarExample03.dayScrollBGColor = UIColorFromRGB(0xf2e51b);
    calendarExample03.dayNameSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample03.dayNumberSelectedTextColor = UIColorFromRGB(0xFFFFFF);
    calendarExample03.daySelectedBGColor = UIColorFromRGB(0xf085a0);
    calendarExample03.startDate = today;
    calendarExample03.endDate = nextDate;
    [self.view addSubview:calendarExample03];
    
    //Third Example with Arabic Language
    calendarExample04 = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, calendarExample03.frame.origin.y+calendarExample03.frame.size.height+10, self.view.frame.size.width, 70)];
    calendarExample04.delegate = self;
    calendarExample04.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    calendarExample04.backgroundColor = UIColorFromRGB(0x232323);
    calendarExample04.monthTextColor = UIColorFromRGB(0x232323);
    calendarExample04.monthBGColor = UIColorFromRGB(0x73ed5f);
    calendarExample04.dayNameTextColor = UIColorFromRGB(0x626262);
    calendarExample04.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendarExample04.dayScrollBGColor = UIColorFromRGB(0x4ac8db);
    calendarExample04.dayNameSelectedTextColor = UIColorFromRGB(0x232323);
    calendarExample04.dayNumberSelectedTextColor = UIColorFromRGB(0x232323);
    calendarExample04.daySelectedBGColor = UIColorFromRGB(0x73ed5f);
    calendarExample04.startDate = today;
    calendarExample04.endDate = nextDate2;
    [self.view addSubview:calendarExample04];
    
    labelDateTest = [[UILabel alloc] initWithFrame:CGRectMake(0, calendarExample04.frame.origin.y+calendarExample04.frame.size.height+30, self.view.frame.size.width, 80)];
    labelDateTest.hidden = TRUE;
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
