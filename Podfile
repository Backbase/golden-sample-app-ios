platform :ios, '15.0'

install! 'cocoapods', deterministic_uuids: false
source 'https://cdn.cocoapods.org/'
source 'https://repo.backbase.com/api/pods/pods'

use_frameworks!
inhibit_all_warnings!

$resolverVersion = '1.2.1'
$backbaseVersion = '~> 12'

abstract_target 'Common' do
  pod 'Backbase', $backbaseVersion
  pod 'RetailFeatureFilterAccessControlEntitlementsUseCase'
  pod 'IdentityAuthenticationJourney','~> 7'
  pod 'BusinessWorkspacesJourney' , '~> 7'
  pod 'BusinessWorkspacesJourneyWorkspacesUseCase2', '~> 7'
  pod 'ArrangementsClient2Gen2','~> 1.2.1'
  pod 'Resolver',  $resolverVersion
  pod 'SwiftLint'
  pod 'BackbaseDesignSystem', '~> 5.6'
  pod 'UserManagerUserProfileUseCase'
  pod 'RetailMoreJourney', '~> 4'
  pod 'BackbaseObservability', '~> 1.0'

  target 'AccountsJourney' do
  end
  
  target 'GoldenAccountsUseCase' do
  end

  target 'GoldenSampleApp' do
    use_frameworks!
  end
end

abstract_target 'Tests' do 
  pod 'Backbase', $backbaseVersion
  pod 'Resolver', $resolverVersion
  
  target 'SnapshotTests' do
      inherit! :search_paths
    end

  target 'AccountsJourneyUnitTests' do 
  end

  target 'GoldenAccountsUseCaseUnitTests' do 
  end
end


post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    
    if target.respond_to?(:product_type)
      puts(target.product_type)
      if target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end

    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      # Our frameworks are built with library evolution support enabled,
      # and they are linked against dependencies with the same setting.
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
