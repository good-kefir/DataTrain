
Pod::Spec.new do |s|


  s.name         = "DataTrain"
  s.version      = "1.0.0"
  s.summary      = "DataTrain framework"
  s.description  = "DataTrain framework"
  s.homepage     = "http://EXAMPLE/DataTrain"
  s.license      = "DataTrain"
  s.author       = { "Ivankov Alexey" => "" }

  s.ios.deployment_target = "10.0"

  s.source       = { :git => 'https://github.com/good-kefir/DataTrain.git', :branch => 'master'  }

  s.source_files  = "DataTrain/**/*.{swift, h}"
  s.xcconfig= {"HEADER_SEARCH_PATHS" => '$(PODS_ROOT)/DataTrain'}

end
