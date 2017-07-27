Pod::Spec.new do |s|
  s.name         = "HandyLogs"
  s.version      = "1.2"
  s.summary      = "Handy Logging Library"
  s.homepage     = "https://github.com/giftbott/HandyLogs"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "giftbott" => "giftbott@gmail.com" }
  s.source       = { :git => "https://github.com/giftbott/HandyLogs.git", :tag => s.version.to_s }
  s.source_files = "Sources/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = "8.0"
end
