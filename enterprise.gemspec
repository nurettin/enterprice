require_relative './lib/version'

Gem::Specification.new do |s|
  s.name= 'enterprise'
  s.version= Enterprise::VERSION
  s.date= '2014-04-07'
  s.summary= 'Programming utilities for quantitative trading'
  s.description= 'This gem provides utilities and methods I use when inspecting time series on remote machines.'
  s.author= 'Nurettin Onur TUĞCU'
  s.email= 'onur.tugcu@gmail.com'
  s.files= Dir.glob('lib/**/*').select{ |d| !File.directory?(d) }
  s.homepage= 'https://github.com/nurettin/enterprise'
  s.license= 'MIT'
end

