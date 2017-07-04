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
NSDateFormatter *dateFormatter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:contentView];
    
    NSLog(@"self.startDate: %@", self.startDate);
    NSLog(@"self.endDate: %@", self.endDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]];
    NSLog(@"dateFormatter.locale : %@", dateFormatter.locale);
    dateFormatter.dateFormat=@"MMM";
    NSString *monthString = [[dateFormatter stringFromDate:self.startDate] uppercaseString];
    NSLog(@"monthString: %@", monthString);
    
    gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:self.startDate
                                                          toDate:self.endDate
                                                         options:0];
    
    UILabel *fixedMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, contentView.frame.size.height)];
    fixedMonthLabel.text = monthString;
    fixedMonthLabel.textAlignment = NSTextAlignmentCenter;
    [fixedMonthLabel setBackgroundColor:self.monthBGColor];
    [fixedMonthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [fixedMonthLabel setTextColor:UIColorFromRGB(0xFFFFFF)];
    [fixedMonthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [fixedMonthLabel setFrame:CGRectMake(0, 0, 45, contentView.frame.size.height)];
    [contentView addSubview:fixedMonthLabel];
    
    UIScrollView *dayScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(fixedMonthLabel.frame.size.width, 0, self.frame.size.width-fixedMonthLabel.frame.size.width, contentView.frame.size.height)];
    [dayScrollView setShowsHorizontalScrollIndicator:FALSE];
    [dayScrollView setShowsVerticalScrollIndicator:FALSE];
    [dayScrollView setBackgroundColor:self.dayScrollBGColor];
    [contentView addSubview:dayScrollView];
    
    int dayContentWidth = (dayScrollView.frame.size.width/7)+3;
    
    for (int i=0; i<[components day]; i++) {
        
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:i];
        NSDate *printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
        
        UIView *dayContentView = [[UIView alloc] initWithFrame:CGRectMake(i*dayContentWidth, 0, dayContentWidth, contentView.frame.size.height)];
        [dayScrollView addSubview:dayContentView];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"eee"];
        NSString *dayNameString = [dateFormatter stringFromDate:printedDate];
        
        int yourDOW = (int)[[gregorianCalendar components:NSCalendarUnitWeekday fromDate:printedDate] weekday];
        
        UILabel *dayNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
        [dayNameLbl setTextAlignment:NSTextAlignmentCenter];
        [dayNameLbl setTextColor:UIColorFromRGB(0x626262)];
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
    
    [dayScrollView setContentSize:CGSizeMake(dayContentWidth * [components day], contentView.frame.size.height)];
}

@end
