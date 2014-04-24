require 'time'
require_relative './lib/version'

Gem::Specification.new do |s|
  s.name= 'enterprice'
  s.version= Enterprice::VERSION
  s.date= Time.now.to_date.to_s
  s.summary= 'Programming utilities for quantitative trading'
  s.description= 'This gem provides utilities and methods I use when inspecting time series on remote machines.'
  s.author= 'Nurettin Onur TUĞCU'
  s.email= 'onur.tugcu@gmail.com'
  s.files= Dir.glob('lib/**/*').reject{ |d| File.directory?(d) }
  s.homepage= 'https://github.com/nurettin/enterprice'
  s.license= 'MIT'
  s.add_development_dependency 'minitest', '~> 0'
  s.add_dependency 'ta-indicator', '~> 0'
  s.required_ruby_version= '~> 2.1'
end

