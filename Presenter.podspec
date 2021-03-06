Pod::Spec.new do |s|
  s.name             = "Presenter"
  s.version          = "1.0.0"
  s.summary          = "Presenter protect ViewController"
  s.description      = <<-DESC
						Presenter protect ViewController.
						[Push, Present, Pop, Dismiss]
                       DESC

  s.homepage         = "https://github.com/muukii/Presenter"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/Presenter.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Presenter/**/*.swift'
end
