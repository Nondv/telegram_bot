# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telegram_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'telegram_bot'
  spec.version       = TelegramBot::VERSION
  spec.authors       = ['Dmitriy Non']
  spec.email         = ['non.dmitriy@gmail.com']

  spec.summary       = 'module for using telegram bots'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '0.36.0'

  spec.add_dependency 'rest-client', '~> 1.8'
end
