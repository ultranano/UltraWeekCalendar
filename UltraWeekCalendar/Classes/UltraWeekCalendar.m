//
//  UltraWeekCalendar.m
//  Pods
//
//  Created by Andrea Baldon on 04/07/2017.
//
//

#import "UltraWeekCalendar.h"

@implementation UltraWeekCalendar

NSCalendar *gregorianCalendar;
NSDateComponents *components;
NSDateFormatter *dateFormatter;
UIView *contentView;
UIView *monthView;
UIView *dayContentView;
UILabel *fixedMonthLabel;
NSMutableArray *breakPointMonths;
NSMutableArray *breakPointMonthsName;
UIScrollView *dayScrollView;
NSDate *printedDate;

int monthContentWidth;
int dayContentWidth;
int currentMonth;
int previousMonth;
int monthNamePosition;
int monthNumber;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        breakPointMonths = [[NSMutableArray alloc] init];
        breakPointMonthsName = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:contentView];
    
    monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [contentView addSubview:monthView];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]];
    dateFormatter.dateFormat=@"MMM";
    NSString *monthString = [[dateFormatter stringFromDate:self.startDate] uppercaseString];
    
    NSLog(@"dateFormatter.locale : %@", dateFormatter.locale);
    NSLog(@"self.startDate: %@", self.startDate);
    NSLog(@"self.endDate: %@", self.endDate);
    NSLog(@"monthString: %@", monthString);
    
    fixedMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, contentView.frame.size.height)];
    fixedMonthLabel.text = monthString;
    fixedMonthLabel.textAlignment = NSTextAlignmentCenter;
    [fixedMonthLabel setBackgroundColor:self.monthBGColor];
    [fixedMonthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [fixedMonthLabel setTextColor:self.monthTextColor];
    [fixedMonthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [fixedMonthLabel setFrame:CGRectMake(0, 0, 45, contentView.frame.size.height)];
    [monthView addSubview:fixedMonthLabel];
    
    [breakPointMonthsName addObject:monthString];
    
    gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    dayScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(fixedMonthLabel.frame.size.width, 0, self.frame.size.width-fixedMonthLabel.frame.size.width, contentView.frame.size.height)];
    [dayScrollView setDelegate:self];
    [dayScrollView setShowsHorizontalScrollIndicator:FALSE];
    [dayScrollView setShowsVerticalScrollIndicator:FALSE];
    [dayScrollView setBackgroundColor:self.dayScrollBGColor];
    [contentView addSubview:dayScrollView];
    
    monthContentWidth = fixedMonthLabel.frame.size.width;
    dayContentWidth = (dayScrollView.frame.size.width/7)+3;
    previousMonth = (int)[[gregorianCalendar components:NSCalendarUnitMonth fromDate:self.startDate] month];
    monthNumber = 0;
    
    components = [gregorianCalendar components:NSCalendarUnitDay
                                      fromDate:self.startDate
                                        toDate:self.endDate
                                       options:0];
    
    for (int i=0; i<[components day]; i++) {
        
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:i];
        
        printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
        currentMonth = (int)[[gregorianCalendar components:NSCalendarUnitMonth fromDate:printedDate] month];
        
        if (previousMonth == currentMonth) {
            //Print only day
            [self renderDay:i withDate:printedDate];
        } else {
            //Print Month + first day
            [self renderMonth:i];
            [self renderDay:i withDate:printedDate];
        }
        
    }
    
    [dayScrollView setContentSize:CGSizeMake((dayContentWidth * [components day]) + (monthContentWidth * monthNumber), contentView.frame.size.height)];
}

#pragma mark - render Month

- (void)renderMonth:(int)index
{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"MMM";
    NSString *currentMonthString = [[dateFormatter stringFromDate:printedDate] uppercaseString];
    
    monthNamePosition = index*dayContentWidth+(monthNumber*monthContentWidth);
    [breakPointMonths addObject:[NSNumber numberWithInt:monthNamePosition]];
    [breakPointMonthsName addObject:currentMonthString];
    
    NSLog(@"breakPointMonths = %d", [[breakPointMonths lastObject] intValue]);
    NSLog(@"breakPointMonthsName = %@", [breakPointMonthsName lastObject]);
    
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
    monthLabel.text = currentMonthString;
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [monthLabel setBackgroundColor:self.monthBGColor];
    [monthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [monthLabel setTextColor:self.monthTextColor];
    [monthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [monthLabel setFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
    [dayScrollView addSubview:monthLabel];
    
    previousMonth = currentMonth;
    monthNumber++;
}

#pragma mark - render Day

- (void)renderDay:(int)index withDate:(NSDate*)printedDate
{
    dayContentView = [[UIView alloc] initWithFrame:CGRectMake(index*dayContentWidth+(monthNumber*monthContentWidth), 0, dayContentWidth, contentView.frame.size.height)];
    [dayScrollView addSubview:dayContentView];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eee"];
    NSString *dayNameString = [dateFormatter stringFromDate:printedDate];
    
    UILabel *dayNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
    [dayNameLbl setTextAlignment:NSTextAlignmentCenter];
    [dayNameLbl setTextColor:self.dayNameTextColor];
    
    int yourDOW = (int)[[gregorianCalendar components:NSCalendarUnitWeekday fromDate:printedDate] weekday];
    //different style for weekend names
    if (yourDOW==1 || yourDOW==7) {
        [dayNameLbl setFont:[UIFont fontWithName:@"Avenir-Heavy" size:13]];
    } else {
        [dayNameLbl setFont:[UIFont fontWithName:@"Avenir-Book" size:13]];
    }
    [dayNameLbl setText:[dayNameString capitalizedString]];
    [dayContentView addSubview:dayNameLbl];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayString = [dateFormatter stringFromDate:printedDate];
    
    UILabel *numberLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, dayContentView.frame.size.height/2, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
    [numberLbl setTextAlignment:NSTextAlignmentCenter];
    [numberLbl setTextColor:self.dayNumberTextColor];
    [numberLbl setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [numberLbl setText:dayString];
    [dayContentView addSubview:numberLbl];
}

#pragma mark - UIScrollView delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (int i=0; i<[breakPointMonths count]; i++) {
        if (scrollView.contentOffset.x <= [[breakPointMonths objectAtIndex:i] intValue]) {
            [fixedMonthLabel setText:[breakPointMonthsName objectAtIndex:i]];
            break;
        }
    }
}

@end
