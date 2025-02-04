Pod::Spec.new do |s|
    s.name = 'AppCommon'
    s.version = '0.0.1'
    s.summary = 'AppCommon'
    s.description = s.summary
    s.license = 'Backbase License'
    s.homepage = 'http://www.backbase.com/home'
    s.author = 'Backbase B.V.'
  
    s.platform = :ios
    s.ios.deployment_target = '15.0'
  
    # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.source = { git: 'https://github.com/backbase/golden-sample-app-ios' }
  
    s.source_files = 'appCommon/**/*'
    s.exclude_files = 'appCommon/Info.plist'
  
    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.vendored_frameworks = 'AppCommon.xcframework'
  
    # ――― Dependencies ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.dependency 'Backbase', '>= 9.0'
  end