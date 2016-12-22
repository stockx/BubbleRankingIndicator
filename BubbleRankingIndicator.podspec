Pod::Spec.new do |s|
  s.name               = "BubbleRankingIndicator"
  s.version            = "0.3.1"
  s.summary            = "A customizable circular ranking indicator."
  s.homepage           = "https://github.com/stockx/BubbleRankingIndicator"
  s.license            = "MIT"
  s.author             = { "Josh Sklar" => "jrmsklar@gmail.com" }
  s.social_media_url   = "https://instagram.com/jrmsklar"
  s.platform           = :ios
  s.platform           = :ios, "8.2"
  s.source             = { :git => "https://github.com/stockx/BubbleRankingIndicator", :tag => s.version}
  s.source_files       = "Source/**/*.swift"
  s.dependency           "SnapKit"
  s.dependency           "HanekeSwift"
end
