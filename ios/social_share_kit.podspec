#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint social_share_kit.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'social_share_kit'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin thats support share files to social media like Tiktok, Instagram, Facebook, WhatsApp, Telegram and more'
  s.description      = <<-DESC
A Flutter plugin thats support share files to social media like Tiktok, Instagram, Facebook, WhatsApp, Telegram and more
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.dependency 'Flutter'
  s.dependency 'TikTokOpenSDK'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
