# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

target 'NaynCo' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  pod 'AFNetworking'
  pod 'Mantle'
  pod 'Masonry'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'GoogleAnalytics'
  pod 'Firebase/Core'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Performance'
  pod 'Firebase/Messaging'
  pod 'InsightfulPager'
  pod 'SMPageControl'
  pod 'GoogleToolboxForMac/NSString+HTML'
  pod 'DTFoundation'
  pod 'HTMLKit'
  pod 'GiphyCoreSDK', :git => 'https://github.com/seyfeddin/giphy-ios-sdk-core.git', :branch => 'master'
  pod 'SDWebImage'
  pod 'FLAnimatedImage'
  pod 'Reveal-SDK', '11', :configurations => ['Debug']
  pod 'NSAttributedString-DDHTML'
  pod 'TwitterKit'
  pod 'FBSDKShareKit'
  pod 'FBSDKMessengerShareKit'
  pod 'XLPagerTabStrip', :git => 'https://github.com/xmartlabs/XLPagerTabStrip.git', :branch => 'obj-c'

  # Pods for NaynCo

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'GiphyCoreSDK'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.2'
              end
          end
      end
  end

end
