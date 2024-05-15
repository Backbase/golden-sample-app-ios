platform :ios, '15.0'

# The following JFrog artifactory repositories should include
# - https://repo.backbase.com/api/pods/ios3/ (backbase-pods3)
# - https://repo.backbase.com/api/pods/ios-retail3/ (backbase-pods-retail3)
# - https://repo.backbase.com/api/pods/ios-identity/ (backbase-pods-identity)
# - https://repo.backbase.com/api/pods/ios-business/ (backbase-pods-business)
# - https://repo.backbase.com/api/pods/design-ios/ (backbase-pods-design)
plugin 'cocoapods-art', sources: %w[
  backbase-pods3
  backbase-pods-retail3
  backbase-pods-identity
  backbase-pods-business
  backbase-pods-design
]

install! 'cocoapods', deterministic_uuids: false
source 'https://cdn.cocoapods.org/'

use_frameworks!
inhibit_all_warnings!

$resolverVersion = '1.2.1'
$backbaseVersion = '11.2.0'

abstract_target 'Common' do
  pod 'Backbase', $backbaseVersion
  pod 'RetailFeatureFilterAccessControlEntitlementsUseCase'
  pod 'IdentityAuthenticationJourney','~> 6.0'
  pod 'BusinessWorkspacesJourney'
  pod 'BusinessWorkspacesJourneyWorkspacesUseCase2'
  pod 'ArrangementsClient2Gen2','~> 1.2.1'
  pod 'Resolver',  $resolverVersion
  pod 'SwiftLint'
  pod 'Alamofire'

  pod 'BackbaseDesignSystem', '4.2.2'
  pod 'UserManagerUserProfileUseCase'
  pod 'RetailMoreJourney', '4.1.0'
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
