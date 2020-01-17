# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bootpay/version'
require 'bootpay-rest-client'
require 'bootpay/server_api'

Gem::Specification.new do |spec|
  spec.name    = 'bootpay-rest-client'
  spec.version = Bootpay::VERSION
  spec.authors = ['gosomi']
  spec.email   = ['gosomi@forelf.com']

  spec.summary     = '부트페이 결제 후 - 검증과 취소요청 모듈입니다.'
  spec.description = '서버사이드용 루비버전입니다.'
  spec.homepage    = 'https://www.bootpay.co.kr'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'activesupport', '> 5.0.0'
  spec.add_dependency 'rack'
  spec.add_dependency 'rest-client'
end
