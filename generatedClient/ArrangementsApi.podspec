Pod::Spec.new do |s|
  s.name = 'ArrangementsApi'
  s.version = '1.0.0'
  s.summary = 'ArrangementsApi'
  s.description = 'ArrangementsApi'
  s.license = 'Backbase License'
  s.homepage = 'https://backbase.io/for-developers'
  s.author = 'Backbase B.V.'

  s.platform = :ios
  s.ios.deployment_target = '15.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source = { :git => 'https://github.com/backbase-rnd/backbase-generated-clients-ios/tree/main/ios-clients/ArrangementsApi'}
  s.source_files = 'ArrangementsApi/Classes/**/*.swift'

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.vendored_frameworks = 'ArrangementsApi.xcframework'

  # ――― Dependencies ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.dependency 'Backbase', '>= 9.0'
  s.dependency 'ClientCommonGen2', '>= 1.0'
end