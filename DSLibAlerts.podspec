#
# Be sure to run `pod lib lint DSLibAlerts.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DSLibAlerts"
  s.version          = "1.0.0"
  s.summary          = "A library for displaying alerts to user."
  s.description      = <<-DESC
A library for displaying alerts for user. Description to written.
                       DESC
  s.homepage         = "https://github.com/diejmon/DSLibAlerts"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alexander Belyavskiy" => "diejmon@gmail.com" }
  s.source           = { :git => "https://github.com/diejmon/DSLibAlerts.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DSLibAlerts' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'DSLibCore'
end
