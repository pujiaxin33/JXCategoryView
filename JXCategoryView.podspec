#
#  Be sure to run `pod spec lint JXCategoryView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "JXCategoryView"
  s.version = "1.6.1"
  s.summary      = "A powerful and easy to use category view (segment view, segment control, page view, scroll viewcontroller) "
  s.homepage     = "https://github.com/pujiaxin33/JXCategoryView"
  s.license      = "MIT"
  s.author             = { "pujiaxin33" => "317437084@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/pujiaxin33/JXCategoryView.git", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/**/*.{h,m}"
  s.requires_arc = true
  
end
