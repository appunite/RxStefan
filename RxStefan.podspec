Pod::Spec.new do |s|

  s.name         = "RxStefan"
  s.version      = "0.1"
  s.summary      = "RxStefan - reactive extensions for Stefan."

  s.homepage     = "https://github.com/appunite/RxStefan"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.authors = { 'Szymon Mrozek' => 'szymon.mrozek.sm@gmail.com' }

  s.platform     = :ios
  s.ios.deployment_target = '9.3'
  s.dependency "Stefan", "~> 0.2"
  s.dependency "RxSwift", "~> 4.1"
  s.dependency "RxCocoa", "~> 4.1"

  s.swift_version = "4.0"

  s.source       = { :git => "https://github.com/appunite/RxStefan.git", :tag => "#{s.version}" }
  s.source_files  = "RxStefan/*.swift"

end
