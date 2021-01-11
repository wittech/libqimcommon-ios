# Uncomment the next line to define a global platform for your project
#plugin "cocoapods-mPaaS", :show_all_specs => true
#mPaaS_baseline '10.1.68'  # 请将 x.x.x 替换成真实基线版本
#mPaaS_version_code 24   # This line is maintained by MPaaS plugin automatically. Please don't modify.
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/wittech/libqimkit-ios-cook.git'
#source "https://code.aliyun.com/mpaas-public/podspecs.git"

target 'QIMCommon' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for QIMCommon
  
    pod 'QIMKitVendor', '~> 4.0'

    pod 'QIMCommonCategories', '~> 4.0'
    pod 'QIMDataBase', '~> 4.0'
    pod 'QIMOpenSSL'

    pod 'ASIHTTPRequest'
    pod 'YYCache'
    pod 'YYModel'
 
    pod 'CocoaLumberjack'
    pod 'UICKeyChainStore'
    pod 'CocoaAsyncSocket'
    
    pod 'AvoidCrash'
    pod 'YYDispatchQueuePool'
    pod 'WCDB'

    #还要换回来，可以移除mpaas的
    pod 'SDWebImage'
end
