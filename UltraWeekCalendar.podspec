#
# Be sure to run `pod lib lint UltraWeekCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UltraWeekCalendar'
  s.version          = '0.1.2'
  s.summary          = 'A clean and compact UI to select days through weeks'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
I need a clean UI for one of my apps to visualize a full customizable UI with week Calendar. The result of this it's UltraWeekCalendar! This is my first pods. Please feel Free to contribute and give me any feedbacks!
DESC
  s.homepage         = 'https://github.com/ultranano/UltraWeekCalendar'
  s.screenshots      = 'http://www.ultranano.net/ultraweekcalendar/screenshots_1.png', 'http://www.ultranano.net/ultraweekcalendar/screenshots_2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrea Baldon' => 'ultranano@hotmail.com' }
  s.source           = { :git => 'https://github.com/ultranano/UltraWeekCalendar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ultranano'

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'UltraWeekCalendar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UltraWeekCalendar' => ['UltraWeekCalendar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
