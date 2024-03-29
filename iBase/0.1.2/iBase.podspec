
Pod::Spec.new do |spec|
  spec.name         = "iBase"
  spec.version      = "0.1.2"
  spec.summary      = "This is a amazing alert library."
  spec.description  = "This is a nice library for IOS.it has several custom Alerts."
  spec.homepage     = "https://github.com/LahiruChathuranga/TestiBase"
  spec.license      = { :type => "MIT", :file => "LICENSE" }  
  spec.author             = { "Lahiru Chathuranga" => "hiru.wlc@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = '4.0'
  spec.source       = { :git => "https://github.com/LahiruChathuranga/TestiBase.git", :tag => "0.1.2" }
  spec.source_files  = "iBase/*.{h, swift}"
  spec.frameworks = "iBaseSwagger", "SwiftyJSON"
  #spec.resources = "iBase/*.swift"
  spec. static_framework = true
  spec.dependency 'iBaseSwagger', '~> 1.0.0'
  spec.dependency 'SwiftyJSON'
  
  
end
