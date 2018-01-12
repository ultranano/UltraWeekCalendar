//
//  UltraWeekCalendar.m
//  Pods
//
//  Created by Andrea Baldon on 04/07/2017.
//
//

#import "UltraWeekCalendar.h"

@implementation UltraWeekCalendar
{
    @private NSCalendar *gregorianCalendar;
    @private NSDateComponents *components;
    @private NSDateFormatter *dateFormatter;
    @private UIView *contentView;
    @private UIView *monthView;
    @private UIView *dayContentView;
    @private UIButton *dayBtn;
    @private UILabel *fixedMonthLabel;
    @private NSMutableArray *breakPointMonths;
    @private NSMutableArray *breakPointMonthsName;
    @private UILabel *dayNameLbl;
    @private UILabel *dayNumberLbl;
    @private NSDate *printedDate;
    
    @private int monthContentWidth;
    @private int dayContentWidth;
    @private int currentMonth;
    @private int previousMonth;
    @private int monthNamePosition;
    @private int monthNumber;
    @private int selectedDay;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dateFormatter = [[NSDateFormatter alloc] init];
        
        breakPointMonths = [[NSMutableArray alloc] init];
        breakPointMonthsName = [[NSMutableArray alloc] init];
        
        selectedDay = 1000;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    //Set calendar default values
    [self setCalendarDefaultValues];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:contentView];
    
    monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [contentView addSubview:monthView];
    
    dateFormatter.dateFormat=@"MMM";
    NSString *monthString = [[dateFormatter stringFromDate:self.startDate] uppercaseString];
    
    NSLog(@"dateFormatter.locale : %@", dateFormatter.locale);
    NSLog(@"self.startDate: %@", self.startDate);
    NSLog(@"self.endDate: %@", self.endDate);
    NSLog(@"monthString: %@", monthString);
    
    fixedMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.fixedMonthLabelWidth, contentView.frame.size.height)];
    fixedMonthLabel.text = monthString;
    fixedMonthLabel.textAlignment = NSTextAlignmentCenter;
    [fixedMonthLabel setBackgroundColor:self.monthBGColor];
    [fixedMonthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [fixedMonthLabel setTextColor:self.monthTextColor];
    [fixedMonthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [fixedMonthLabel setFrame:CGRectMake(0, 0, self.fixedMonthLabelWidth, contentView.frame.size.height)];
    [monthView addSubview:fixedMonthLabel];

    [breakPointMonthsName addObject:monthString];
    
    self.dayScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(fixedMonthLabel.frame.size.width+1, 0, self.frame.size.width-fixedMonthLabel.frame.size.width-1, contentView.frame.size.height)];
    [self.dayScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.dayScrollView setDelegate:self];
    [self.dayScrollView setShowsHorizontalScrollIndicator:FALSE];
    [self.dayScrollView setShowsVerticalScrollIndicator:FALSE];
    [self.dayScrollView setBackgroundColor:self.dayScrollBGColor];
    [contentView addSubview:self.dayScrollView];
    
    monthContentWidth = fixedMonthLabel.frame.size.width;
    dayContentWidth = (self.dayScrollView.frame.size.width/7)+3;
    previousMonth = (int)[[gregorianCalendar components:NSCalendarUnitMonth fromDate:self.startDate] month];
    monthNumber = 0;
    
    components = [gregorianCalendar components:NSCalendarUnitDay
                                      fromDate:self.startDate
                                        toDate:self.endDate
                                       options:0];
    
    for (int i=0; i<[components day]; i++) {
        
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
    
    int totalWidth = (int)(dayContentWidth * [components day]) + (monthContentWidth * monthNumber);
    [breakPointMonths addObject:[NSNumber numberWithInt:totalWidth]];
    [breakPointMonthsName addObject:[breakPointMonthsName lastObject]];
    
    [self.dayScrollView setContentSize:CGSizeMake(totalWidth, contentView.frame.size.height)];
}

#pragma mark - set Calendar Default Values

- (void)setCalendarDefaultValues
{
    if (self.fixedMonthLabelWidth==0) {             self.fixedMonthLabelWidth = 45;}
    if (self.monthTextColor == nil)                 {self.monthTextColor = UIColorFromRGB(0xCCCCCC);}
    if (self.monthBGColor == nil)                   {self.monthBGColor = UIColorFromRGB(0xe54848);}
    if (self.dayNameTextColor == nil)               {self.dayNameTextColor = UIColorFromRGB(0x626262);}
    if (self.dayNumberTextColor == nil)             {self.dayNumberTextColor = UIColorFromRGB(0x232323);}
    if (self.dayScrollBGColor == nil)               {self.dayScrollBGColor = UIColorFromRGB(0xCCCCCC);}
    if (self.dayNameSelectedTextColor == nil)       {self.dayNameSelectedTextColor = UIColorFromRGB(0xCCCCCC);}
    if (self.dayNumberSelectedTextColor == nil)     {self.dayNumberSelectedTextColor = UIColorFromRGB(0xCCCCCC);}
    if (self.daySelectedBGColor == nil)             {self.daySelectedBGColor = UIColorFromRGB(0xe54848);}
    if (self.languageLocale == nil) { dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]]; } else { dateFormatter.locale = self.languageLocale;}
}

#pragma mark - render Month

- (void)renderMonth:(int)index
{
    dateFormatter.dateFormat=@"MMM";
    NSString *currentMonthString = [[dateFormatter stringFromDate:printedDate] uppercaseString];
    
    monthNamePosition = index*dayContentWidth+(monthNumber*monthContentWidth);
    [breakPointMonths addObject:[NSNumber numberWithInt:monthNamePosition]];
    [breakPointMonthsName addObject:currentMonthString];
    
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
    monthLabel.text = currentMonthString;
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [monthLabel setBackgroundColor:self.monthBGColor];
    [monthLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [monthLabel setTextColor:self.monthTextColor];
    [monthLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [monthLabel setFrame:CGRectMake(monthNamePosition, 0, monthContentWidth, contentView.frame.size.height)];
    [self.dayScrollView addSubview:monthLabel];
    
    previousMonth = currentMonth;
    monthNumber++;
}

#pragma mark - render Day

- (void)renderDay:(int)index withDate:(NSDate*)currentDate
{
    dayContentView = [[UIView alloc] initWithFrame:CGRectMake(index*dayContentWidth+(monthNumber*monthContentWidth), 0, dayContentWidth, contentView.frame.size.height)];
    dayContentView.tag = index+1000;
    [self.dayScrollView addSubview:dayContentView];
    
    [dateFormatter setDateFormat:@"eee"];
    NSString *dayNameString = [dateFormatter stringFromDate:currentDate];
    
    dayNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
    dayNameLbl.tag = index+2000;
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
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayString = [dateFormatter stringFromDate:currentDate];
    
    dayNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, dayContentView.frame.size.height/2, dayContentView.frame.size.width, dayContentView.frame.size.height/2)];
    dayNumberLbl.tag = index+3000;
    [dayNumberLbl setTextAlignment:NSTextAlignmentCenter];
    [dayNumberLbl setTextColor:self.dayNumberTextColor];
    [dayNumberLbl setFont:[UIFont fontWithName:@"Avenir-Medium" size:15]];
    [dayNumberLbl setText:dayString];
    [dayContentView addSubview:dayNumberLbl];
    
    dayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dayContentView.frame.size.width, dayContentView.frame.size.height)];
    dayBtn.tag = index+4000;
    [dayBtn addTarget:self action:@selector(selectedDay:) forControlEvents:UIControlEventTouchUpInside];
    [dayContentView addSubview:dayBtn];
}

#pragma mark - selected Day

- (void)selectedDay:(id)sender
{
    int dayOffset = (int)[sender tag]-4000;
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:dayOffset];
    printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
    dateFormatter.dateFormat=@"yyyy-MM-dd'T'HH:mm:ssZ";
    NSString *selectedDayStr = [dateFormatter stringFromDate:printedDate];
    
    if ([selectedDayStr isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDayStr"]]) {
        if (![[self viewWithTag:dayOffset+1000].backgroundColor isEqual:[UIColor clearColor]]) {
            [[self viewWithTag:dayOffset+1000] setBackgroundColor:[UIColor clearColor]];
            [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameTextColor];
            [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberTextColor];
            
            selectedDayStr = nil;
            self.selectedDate = nil;
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"selectedDayStr"];
            [delegate dateButtonClicked];
            NSLog(@"selectedDay %@", selectedDayStr);
            
        } else {
            [[self viewWithTag:dayOffset+1000] setBackgroundColor:self.daySelectedBGColor];
            [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameSelectedTextColor];
            [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberSelectedTextColor];
            
            selectedDay = dayOffset+1000;
            self.selectedDate = printedDate;
            [[NSUserDefaults standardUserDefaults] setObject:selectedDayStr forKey:@"selectedDayStr"];
            
            [delegate dateButtonClicked];
            NSLog(@"selectedDay %@", selectedDayStr);
        }
    } else {
        [[self viewWithTag:selectedDay] setBackgroundColor:[UIColor clearColor]];
        [[self viewWithTag:selectedDay+1000] setTextColor:self.dayNameTextColor];
        [[self viewWithTag:selectedDay+2000] setTextColor:self.dayNumberTextColor];
        
        [[self viewWithTag:dayOffset+1000] setBackgroundColor:self.daySelectedBGColor];
        [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameSelectedTextColor];
        [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberSelectedTextColor];
        
        selectedDay = dayOffset+1000;
        self.selectedDate = printedDate;
        [[NSUserDefaults standardUserDefaults] setObject:selectedDayStr forKey:@"selectedDayStr"];
        
        [delegate dateButtonClicked];
        NSLog(@"selectedDay %@", selectedDayStr);
    }
}

#pragma mark - selected Date

- (void)selectedDate:(int)dayOffset
{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:dayOffset];
    printedDate = [gregorianCalendar dateByAddingComponents:offsetComponents toDate:self.startDate options:0];
    dateFormatter.dateFormat=@"yyyy-MM-dd'T'HH:mm:ssZ";
    NSString *selectedDayStr = [dateFormatter stringFromDate:printedDate];
    
    if ([selectedDayStr isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDayStr"]]) {
        if (![[self viewWithTag:dayOffset+1000].backgroundColor isEqual:[UIColor clearColor]]) {
            [[self viewWithTag:dayOffset+1000] setBackgroundColor:[UIColor clearColor]];
            [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameTextColor];
            [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberTextColor];
            
            selectedDayStr = nil;
            self.selectedDate = nil;
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"selectedDayStr"];
            [delegate dateButtonClicked];
            NSLog(@"selectedDay %@", selectedDayStr);
            
        } else {
            [[self viewWithTag:dayOffset+1000] setBackgroundColor:self.daySelectedBGColor];
            [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameSelectedTextColor];
            [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberSelectedTextColor];
            
            selectedDay = dayOffset+1000;
            self.selectedDate = printedDate;
            [[NSUserDefaults standardUserDefaults] setObject:selectedDayStr forKey:@"selectedDayStr"];
            
            NSLog(@"selectedDay %@", selectedDayStr);
        }
    } else {
        [[self viewWithTag:selectedDay] setBackgroundColor:[UIColor clearColor]];
        [[self viewWithTag:selectedDay+1000] setTextColor:self.dayNameTextColor];
        [[self viewWithTag:selectedDay+2000] setTextColor:self.dayNumberTextColor];
        
        [[self viewWithTag:dayOffset+1000] setBackgroundColor:self.daySelectedBGColor];
        [[self viewWithTag:dayOffset+2000] setTextColor:self.dayNameSelectedTextColor];
        [[self viewWithTag:dayOffset+3000] setTextColor:self.dayNumberSelectedTextColor];
        
        selectedDay = dayOffset+1000;
        self.selectedDate = printedDate;
        [[NSUserDefaults standardUserDefaults] setObject:selectedDayStr forKey:@"selectedDayStr"];
        
        NSLog(@"selectedDay %@", selectedDayStr);
    }
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
