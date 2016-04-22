
Pod::Spec.new do |s|
  s.name             = "DSLibAlerts"
  s.version          = "2.0.0"
  s.summary          = "A library for displaying alerts to user."
  s.description      = <<-DESC
A library for displaying alerts for user. Description to written.
                       DESC
  s.homepage         = "https://github.com/diejmon/DSLibAlerts"
  s.license          = 'MIT'
  s.author           = { "Alexander Belyavskiy" => "diejmon@gmail.com" }
  s.source           = { :git => "https://github.com/diejmon/DSLibAlerts.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'DSLibCore'
  s.dependency 'SystemWindowController'
end
