platform :ios, '14.0'

# The following JFrog artifactory repositories should include
# - https://repo.backbase.com/api/pods/ios3/ (backbase-pods3)
# - https://repo.backbase.com/api/pods/ios-retail3/ (backbase-pods-retail3)
# - https://repo.backbase.com/api/pods/ios-identity/ (ios-identity)
# - https://repo.backbase.com/api/pods/ios-mobile-notifications/ (ios-mobile-notifications)
# - https://repo.backbase.com/api/pods/ios-engagement-channels/ (ios-engagement-channels)
# - https://repo.backbase.com/api/pods/ios-mitek-misnap/ (backbase-pods-mitek-misnap)
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
$backbaseVersion = '>= 9.0'

abstract_target 'Common' do
  pod 'Backbase', $backbaseVersion
  pod 'RetailFeatureFilterAccessControlEntitlementsUseCase'
  pod 'IdentityAuthenticationJourney'
  pod 'BusinessWorkspacesJourney'
  pod 'BusinessWorkspacesJourneyWorkspacesUseCase2'
  pod 'ArrangementsClient2Gen2','~> 1.2.1'
  pod 'Resolver',  $resolverVersion
  
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
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      # Our frameworks are built with library evolution support enabled,
      # and they are linked against dependencies with the same setting.
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
    # update_vg_parallax_pod()
  end

  # Fix swiftinterface files for Xcode 12
  frameworks = ['RetailAccountsAndTransactionsJourney',
                'RetailAccountsAndTransactionsJourneyAccountsUseCase',
                'RetailAccountsAndTransactionsJourneyTransactionsUseCase',
                'RetailCardsManagementJourney',
                'RetailCardsManagementJourneyCardsUseCase',
                'BusinessWorkspacesJourney',
                'BusinessWorkspacesJourneyWorkspacesUseCase2',
                'BusinessJourneyCommon',
                'BusinessDesign']
  frameworks.each do |framework|
    directory = File.join(installer_representation.config.project_pods_root, framework)
    Dir[ File.join(directory, '**', '*') ].reject { |p| File.directory? p
      if File.extname(p) == '.swiftinterface'
        puts("Updating " + p)
        system("sed -i '' 's/import _Concurrency//g' #{p}")
        system("sed -i '' 's/@_Concurrency\.MainActor(unsafe) //g' #{p}")
      end
    }
  end
end
# Temporary fix for this dependency to import correctly one of it's subdependencies
def update_vg_parallax_pod
  filename = [Dir.pwd, "Pods", "VGParallaxHeader", "VGParallaxHeader", "UIScrollView+VGParallaxHeader.m"].join("/")
  File.chmod(0700, filename)
  text = File.read(filename)
  new_contents = text.gsub("#import <PureLayout.h>", "#import <PureLayout/PureLayout.h>")
  File.open(filename, "w") {|file| file.puts new_contents }
end
