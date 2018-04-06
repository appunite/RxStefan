Pod::Spec.new do |s|

  s.name         = "RxStefan"
  s.version      = "0.2.2"
  s.summary      = "RxStefan - reactive extensions for Stefan."

  s.homepage     = "https://github.com/appunite/RxStefan"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.authors = { 'Szymon Mrozek' => 'szymon.mrozek.sm@gmail.com' }

  s.platform     = :ios
  s.ios.deployment_target = '10.0'
  s.dependency "Stefan"
  s.dependency "RxSwift"
  s.dependency "RxCocoa"

  s.swift_version = "4.1"

  s.source       = { :git => "https://github.com/appunite/RxStefan.git", :tag => "#{s.version}" }
  s.source_files  = "RxStefan/*.swift"

end
