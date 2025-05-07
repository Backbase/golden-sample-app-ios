# frozen_string_literal: true

source "https://rubygems.org"

# gem "rails"

gem "cocoapods", "~> 1.13"
gem "fastlane"
gem "activesupport", "~> 7.0", "<= 7.0.8"
gem "slather"
gem "bigdecimal"
gem "abbrev"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
