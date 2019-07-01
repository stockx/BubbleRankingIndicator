source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'

# Frameworks that need to be built using Swift 4.0.
swift_4_0_frameworks = [
  'HanekeSwift',
]

# Main Target
target 'BubbleRankingIndicator' do
  use_frameworks!
  
  # Pods for BubbleRankingIndicator
  pod 'SnapKit'
  pod 'HanekeSwift', :git => 'git@github.com:stockx/HanekeSwift.git', :tag => 'v0.10.1.8'

  target 'BubbleRankingIndicatorTests' do
    inherit! :search_paths
  end

end

# Post-install hook. This will be ran after installing pods and for all targets.
post_install do |installer|
    
  puts 'Set pods to install with specific versions of Swift when needed.'

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if swift_4_0_frameworks.include?(target.name)
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
    
end
