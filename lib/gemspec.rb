#!/usr/bin/env ruby
# Encoding: UTF-8
require 'pathname'
require 'bundler'
Bundler.require (:gemspec_builder) if defined?(Bundler)

module Refinery
  Version='1.1.0'
end

gempath = Pathname.new(File.expand_path('../../', __FILE__))
require gempath.join('lib', 'refinerycms-yuzublog')


files = %w( Gemfile *.md **/**/{*,.rspec,.gitignore,.yardopts} ).map { |file| Pathname.glob(file) }.flatten
rejection_patterns = [
  "^(authentication|base|core|dashboard|images|pages|resources|settings|testing)",
  "^public/system",
  "^public/.*/cache",
  "^config/(application|boot|environment).rb$",
  "^config/initializers(\/.*\.rb)?$",
  "^config/(database|i18n\-js).yml$",
  "^lib\/gemspec\.rb",
  "^index\/*",
  ".*\/cache\/",
  "^db(\/)?",
  "^script\/*",
  "^vendor\/plugins\/?$",
  "(^log|\.log)$",
  "\.rbc$",
  "^tmp(|/.+?)$",
  ".gem$",
  "^doc($|\/)"
]

files.reject! do |f|
  !f.exist? or (f.directory? and f.children.empty?) or f.to_s =~ %r{(#{rejection_patterns.join(')|(')})}
end

gemspec = <<EOF
# Encoding: UTF-8
# DO NOT EDIT THIS FILE DIRECTLY! Instead, use lib/gemspec.rb to generate it.

Gem::Specification.new do |s|
  s.name              = %q{#{gemname = 'refinerycms-yuzublog'}}
  s.version           = %q{#{Refinery::Yuzublog::Version}}
  s.description       = %q{Refinery integration for YuzuTen's Yuzublog project'}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{A multisite-savvy blogging engine that works with RefineryCMS}
  s.email             = %q{jason@yuzuten.com}
  s.homepage          = %q{http://www.yuzuten.com}
  s.rubyforge_project = %q{refinerycms-yuzublog}
  s.authors           = ['YuzuTen LLC', 'Jason Truesdell']
  s.license           = %q{BSD MIT}
  s.require_paths     = %w(lib)
  s.executables       = %w(#{Dir['bin/*'].join(' ').gsub('bin/', '')})

  # Bundler
  s.add_dependency    'bundler',                    '~> 1.0'

  # Refinery CMS
  s.add_dependency    'refinerycms-base',           '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-core',           '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-dashboard',      '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-images',         '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-pages',          '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-resources',      '= #{::Refinery::Version}'
  s.add_dependency    'refinerycms-settings',       '= #{::Refinery::Version}'
  s.add_dependency    'rails', '>= 3.1.0rc4'
  #s.add_dependency    'yuzublog'
  s.files             = [
    '#{files.sort.join("',\n    '")}'
  ]
end
EOF


(gemfile = gempath.join("#{gemname}.gemspec")).open('w') {|f| f.puts(gemspec)}
puts `cd #{gempath} && gem build #{gemfile}` if ARGV.any?{|a| a == "BUILD=true"}