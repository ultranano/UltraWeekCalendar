# UltraWeekCalendar

[![Compatibility](https://img.shields.io/badge/Swift-compatible-brightgreen.svg)]()
[![Version](https://img.shields.io/cocoapods/v/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)
[![License](https://img.shields.io/cocoapods/l/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)
[![Platform](https://img.shields.io/cocoapods/p/UltraWeekCalendar.svg?style=flat)](http://cocoapods.org/pods/UltraWeekCalendar)

UltraWeekCalendar - Clean UI to select day through weeks

<p align="center">
<img src="http://www.ultranano.net/ultraweekcalendar/screenshots_1.png" alt="Screenshot 01"/>
<br>
<img src="http://www.ultranano.net/ultraweekcalendar/screenshots_2.png" alt="Screenshot 02"/>
</p>

## Features:
- [x] Calendar Localizable in all languages
- [x] Change All calendar styles simply update HEX color values
- [x] Fully compatible with Swift (bridging header)
- [x] Fully compatible with Autolayout and rotation changes
- [x] Many many more features to come...

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
//Basic Example

UltraWeekCalendar *calendar = [[UltraWeekCalendar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
calendar.delegate = self;
calendar.startDate = today;
calendar.endDate = nextDate;
[self.view addSubview:calendar];
```

if you want to set Different Languages (ex:Japanese or Italian) specify "languageLocale" option

```ruby
//English
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

//Spanish
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];

//Japanese
calendar.languageLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"jp_JP"];
```

you can full customize color style with a lot of HEX color options

```ruby
//Setting styles after initWithFrame

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

## Contributing

- If you **need help** or you'd like to **ask a general question**, open an issue.
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## MIT License

UltraWeekCalendar is available under the MIT license. See the LICENSE file for more info.
