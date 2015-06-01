#!/usr/bin/env gem build

Gem::Specification.new do |s|
  s.name              = 'cake-coding-exercise'
  s.version           = '0.0.1'
  s.authors           = ['James C Russell']
  s.summary           = 'Cake coding exercise.'

  s.add_runtime_dependency('activerecord', ['~> 4.2'])
end
