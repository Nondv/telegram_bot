# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ya_telegram_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'ya_telegram_bot'
  spec.version       = YATelegramBot::VERSION
  spec.authors       = ['Dmitriy Non']
  spec.email         = ['non.dmitriy@gmail.com']

  spec.summary       = 'Yet Another Telegram Bot'
  spec.description   = 'Module for using Telegram Bot API'
  spec.homepage      = 'https://github.com/Nondv/telegram_bot'
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
