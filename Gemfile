# frozen_string_literal: true

source "https://rubygems.org"

# gem "rails"

gem "cocoapods", '>= 1.16'
gem "fastlane"
gem "activesupport", '>= 7'
gem "slather"
gem "bigdecimal"
gem "abbrev"
# gem 'concurrent-ruby', '1.3.4'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
