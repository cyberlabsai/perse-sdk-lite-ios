Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "PerseLite"
  spec.version      = "0.2.0"
  spec.summary      = "Perse SDK Lite iOS"
  spec.description  = <<-DESC
    "This SDK provides abstracts the communication with the Perse's API endpoints and also convert the response from json to a pre-defined responses."
                   DESC

  spec.homepage     = "https://github.com/cyberlabsai/perse-sdk-lite-ios/"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { 'CyberLabs.AI'   => 'contato@cyberlabs.ai' }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source       = { :git => "https://github.com/cyberlabsai/perse-sdk-lite-ios.git", :tag => "#{spec.version}" }

  spec.ios.deployment_target = '10.0'


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source_files  = "PerseLite/src/**/*", "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  spec.dependency 'Alamofire', '~> 5.2'
end
