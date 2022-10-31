Pod::Spec.new do |s|
  s.name = 'SwaggerClient'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.homepage = 'domkoc.github.io'
  s.summary = 'Api for GG App'
  s.version = '0.0.1'
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.authors = 'Dominik Kocka'
  s.license = 'Proprietary'
  s.source_files = 'SwaggerClient/Classes/**/*.swift'
  s.dependency 'Alamofire', '~> 4.9.0'
end
