#
# Be sure to run `pod lib lint Astaroth.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Astaroth'
  s.version          = '0.6.0'
  s.summary          = 'Logging library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


  s.homepage         = 'https://github.com/horovodovodo4ka/astaroth-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'horovodovodo4ka' => 'xbitstream@gmail.com' }
  s.source           = { :git => 'https://github.com/horovodovodo4ka/astaroth-ios.git', :tag => s.version.to_s }

  s.swift_version = '5.1'

  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'

  s.source_files = 'Astaroth/Classes/**/*'

end
