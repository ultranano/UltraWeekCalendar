# UltraWeekCalendar

[![Compatibility](https://img.shields.io/badge/Swift-compatible-brightgreen.svg)](https://travis-ci.org/ultranano/UltraWeekCalendar)
[![Version](https://img.shields.io/cocoapods/v/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)
[![License](https://img.shields.io/cocoapods/l/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)
[![Platform](https://img.shields.io/cocoapods/p/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 8+

## Installation

UltraWeekCalendar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UltraWeekCalendar"
```

the import the calendar in your view controller simply add

```ruby
#import "UltraWeekCalendar.h"
```

after that init the calendar with a start date and an end date

```ruby
//First Basic Example with English Language
calendar = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, labelTest.frame.origin.y+labelTest.frame.size.height+10, self.view.frame.size.width, 55)];
calendar.delegate = self;
calendar.startDate = today;
calendar.endDate = nextDate;
[self.view addSubview:calendarExample01];
```

if you want to set Different Languages (ex:Japanese or Italian) specify "languageLocale" option

```ruby
//English US
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]; 
//Spanish
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"]; 
//Japanese
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"jp_JP"];
```

you can full customize color style with a lot of HEX color options

```ruby
calendar.backgroundColor = UIColorFromRGB(0xCCCCCC);
calendar.monthTextColor = UIColorFromRGB(0xFFFFFF);
calendar.monthBGColor = UIColorFromRGB(0x7baecb);
calendar.dayNameTextColor = UIColorFromRGB(0x626262);
calendar.dayNumberTextColor = UIColorFromRGB(0x232323);
calendar.dayScrollBGColor = UIColorFromRGB(0xFFFFFF);
calendar.dayNameSelectedTextColor = UIColorFromRGB(0xFFFFFF);
calendar.dayNumberSelectedTextColor = UIColorFromRGB(0xFFFFFF);
calendar.daySelectedBGColor = UIColorFromRGB(0x7baecb);
```

## Author

Andrea Baldon, ultranano@hotmail.com

## License

UltraWeekCalendar is available under the MIT license. See the LICENSE file for more info.
