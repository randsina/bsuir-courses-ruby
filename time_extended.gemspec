# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'time_extended'
  spec.version       = '0.0.6'
  spec.authors       = ['Roman Vakulchik']
  spec.email         = ['rvakulchik@yandex.ru']
  spec.summary       = 'Time extended!'
  spec.description   = 'A simple gem for extension the Ruby class `DateTime`'
  spec.homepage      = 'https://github.com/randsina/bsuir-courses-ruby/tree/master/time_extended'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
