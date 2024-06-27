#
# Be sure to run `pod lib lint TextWithImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TextWithImageView'
  s.version          = '0.1.0'
  s.summary          = 'TextWithImageView 입니다.'

  s.description      = 'TextWithImageView 입니다.'

  s.homepage         = 'https://github.com/sungyoungPark/TextWithImageView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sungyoungPark' => 'sygitter1491012@gmail.com' }
  s.source           = { :git => 'https://github.com/sungyoungPark/TextWithImageView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'TextWithImageView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TextWithImageView' => ['TextWithImageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kingfisher', '~> 7.0'
  s.dependency 'SnapKit', '~> 5.7.0'
end
