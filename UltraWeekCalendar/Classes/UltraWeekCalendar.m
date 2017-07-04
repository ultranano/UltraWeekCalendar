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
UIView *monthView;
UIView *dayContentView;
UILabel *fixedMonthLabel;
NSMutableArray *breakPointMonths;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        breakPointMonths = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:contentView];
    
    monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [contentView addSubview:monthView];
    
    NSLog(@"self.startDate: %@", self.startDate);
    NSLog(@"self.endDate: %@", self.endDate);
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]];
    NSLog(@"dateFormatter.locale : %@", dateFormatter.locale);
    dateFormatter.dateFormat=@"MMM";
    NSString *monthString = [[dateFormatter stringFromDate:self.startDate] uppercaseString];
    NSLog(@"monthString: %@", monthString);
    
    gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    components = [gregorianCalendar components:NSCalendarUnitMonth
                                                        fromDate:self.startDate
                                                          toDate:self.endDate
                                                         options:0];
    
    for (int i=0; i<[components month]; i++) {
        
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setMonth:i];
        NSDate *printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat=@"MMM";
        NSString *monthString = [[dateFormatter stringFromDate:printedDate] uppercaseString];
        
        fixedMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*45, 0, 45, contentView.frame.size.height)];
        fixedMonthLabel.text = monthString;
        fixedMonthLabel.textAlignment = NSTextAlignmentCenter;
        [fixedMonthLabel setBackgroundColor:self.monthBGColor];
        [fixedMonthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
        [fixedMonthLabel setTextColor:UIColorFromRGB(0xFFFFFF)];
        [fixedMonthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        [fixedMonthLabel setFrame:CGRectMake(i*45, 0, 45, contentView.frame.size.height)];
        [monthView addSubview:fixedMonthLabel];
    }
    
    [monthView setFrame:CGRectMake(0, 0, 45*[components month], self.frame.size.height)];
    
    UIScrollView *dayScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(fixedMonthLabel.frame.size.width, 0, self.frame.size.width-fixedMonthLabel.frame.size.width, contentView.frame.size.height)];
    [dayScrollView setDelegate:self];
    //[dayScrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
    [dayScrollView setShowsHorizontalScrollIndicator:FALSE];
    [dayScrollView setShowsVerticalScrollIndicator:FALSE];
    [dayScrollView setBackgroundColor:self.dayScrollBGColor];
    [contentView addSubview:dayScrollView];
    
    int monthContentWidth = fixedMonthLabel.frame.size.width;
    int dayContentWidth = (dayScrollView.frame.size.width/7)+3;
    int previousMonth = (int)[[gregorianCalendar components:NSCalendarUnitMonth fromDate:self.startDate] month];
    int monthNumber = 0;
    
    components = [gregorianCalendar components:NSCalendarUnitDay
                                      fromDate:self.startDate
                                        toDate:self.endDate
                                       options:0];
    
    for (int i=0; i<[components day]; i++) {
        
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:i];
        NSDate *printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
        
        int currentMonth = (int)[[gregorianCalendar components:NSCalendarUnitMonth fromDate:printedDate] month];
        
        if (previousMonth == currentMonth) {
            dayContentView = [[UIView alloc] initWithFrame:CGRectMake(i*dayContentWidth+(monthNumber*monthContentWidth), 0, dayContentWidth, contentView.frame.size.height)];
            [dayScrollView addSubview:dayContentView];
            [self renderDay:printedDate];
        } else {
            
            int monthNamePosition = i*dayContentWidth+(monthNumber*monthContentWidth);
            [breakPointMonths addObject:[NSNumber numberWithInt:monthNamePosition]];
            
            NSLog(@"breakPointMonths = %d", [[breakPointMonths lastObject] intValue]);
            
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat=@"MMM";
            NSString *currentMonthString = [[dateFormatter stringFromDate:printedDate] uppercaseString];
            
            UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
            monthLabel.text = currentMonthString;
            monthLabel.textAlignment = NSTextAlignmentCenter;
            [monthLabel setBackgroundColor:self.monthBGColor];
            [monthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
            [monthLabel setTextColor:UIColorFromRGB(0xFFFFFF)];
            [monthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            [monthLabel setFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
            [dayScrollView addSubview:monthLabel];
            
            previousMonth = currentMonth;
            monthNumber++;
            
            dayContentView = [[UIView alloc] initWithFrame:CGRectMake(i*dayContentWidth+(monthNumber*monthContentWidth), 0, dayContentWidth, contentView.frame.size.height)];
            [dayScrollView addSubview:dayContentView];
            [self renderDay:printedDate];
        }
        
    }
    
    [dayScrollView setContentSize:CGSizeMake((dayContentWidth * [components day]) + (monthContentWidth * monthNumber), contentView.frame.size.height)];
}

- (void)renderDay:(NSDate*)printedDate
{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eee"];
    NSString *dayNameString = [dateFormatter stringFromDate:printedDate];
    
    UILabel *dayNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
    [dayNameLbl setTextAlignment:NSTextAlignmentCenter];
    [dayNameLbl setTextColor:UIColorFromRGB(0x626262)];
    
    int yourDOW = (int)[[gregorianCalendar components:NSCalendarUnitWeekday fromDate:printedDate] weekday];
    //different colors for weekend names
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
    [numberLbl setTextColor:UIColorFromRGB(0x232323)];
    [numberLbl setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [numberLbl setText:dayString];
    [dayContentView addSubview:numberLbl];
}

#pragma mark - UIScrollView delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%d", (int)scrollView.contentOffset.x);
    
    for (int i=0; i<[breakPointMonths count]; i++) {
        if (scrollView.contentOffset.x >= [[breakPointMonths objectAtIndex:i] intValue] && scrollView.contentOffset.x <= [[breakPointMonths objectAtIndex:i] intValue]+45) {
            
            if (self.lastContentOffset > scrollView.contentOffset.x) {
                NSLog(@"move month forward %f", +(scrollView.contentOffset.x-[[breakPointMonths objectAtIndex:i] intValue]+(i*45)));
                [monthView setFrame:CGRectMake(+(scrollView.contentOffset.x-[[breakPointMonths objectAtIndex:i] intValue]+(i*45)), monthView.frame.origin.y, monthView.frame.size.width, monthView.frame.size.height)];
            } else if (self.lastContentOffset < scrollView.contentOffset.x) {
                NSLog(@"move month backward %f", -(scrollView.contentOffset.x-[[breakPointMonths objectAtIndex:i] intValue]+(i*45)));
                [monthView setFrame:CGRectMake(-(scrollView.contentOffset.x-[[breakPointMonths objectAtIndex:i] intValue]+(i*45)), monthView.frame.origin.y, monthView.frame.size.width, monthView.frame.size.height)];
            }
            
            break;
        }
    }
    
    self.lastContentOffset = scrollView.contentOffset.x;
}

@end
