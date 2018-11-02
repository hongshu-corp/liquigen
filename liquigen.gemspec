# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','liquigen','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'liquigen'
  s.version = Liquigen::VERSION
  s.author = 'Jeremy Cui'
  s.email = 'tsuijy@gmail.com'
  s.homepage = 'http://github.com/jerecui'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Simple tool for generating the liquibase script.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.extra_rdoc_files = ['README.rdoc','liquigen.rdoc']
  s.rdoc_options << '--title' << 'liquigen' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'liquigen'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.18.0')
end
