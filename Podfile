# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SampleAPIApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

 pod 'Alamofire'
  pod 'SwiftyJSON'
pod 'RappleProgressHUD'
  # Pods for SampleAPIApp


end

post_install do |installer|
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end