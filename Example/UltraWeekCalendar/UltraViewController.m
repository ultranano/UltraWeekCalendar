//
//  UltraViewController.m
//  UltraWeekCalendar
//
//  Created by Andrea Baldon on 07/04/2017.
//  Copyright (c) 2017 Andrea Baldon. All rights reserved.
//

#import "UltraViewController.h"
#import "UltraWeekCalendar.h"

@interface UltraViewController ()

@end

@implementation UltraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:6];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    
    UltraWeekCalendar *calendar = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 55)];
    calendar.backgroundColor = UIColorFromRGB(0xCCCCCC);
    calendar.monthTextColor = UIColorFromRGB(0xFFFFFF);
    calendar.monthBGColor = UIColorFromRGB(0x7baecb);
    calendar.dayNameTextColor = UIColorFromRGB(0x626262);
    calendar.dayNumberTextColor = UIColorFromRGB(0x232323);
    calendar.daySelectedBGColor = [UIColor redColor];
    calendar.dayScrollBGColor = UIColorFromRGB(0xFFFFFF);
    calendar.startDate = today;
    calendar.endDate = nextDate;
    [self.view addSubview:calendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
