Pod::Spec.new do |s|
    s.name = 'AccountsJourney'
    s.version = '0.0.1'
    s.summary = 'AccountsJourney'
    s.description = s.summary
    s.license = 'Backbase License'
    s.homepage = 'http://www.backbase.com'
    s.author = 'Backbase B.V.'
  
    s.platform = :ios
    s.ios.deployment_target = '15.0'
  
    # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.source = { git: 'https://github.com/backbase/golden-sample-app-ios.git' }
  
    s.source_files = 'Sources/AccountsJourney/**/*'
    s.exclude_files = 'Sources/AccountsJourney/Info.plist'
  
    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.vendored_frameworks = 'AccountsJourney.xcframework'
  
    # ――― Dependencies ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.dependency 'Backbase', '>= 9.0'
  end