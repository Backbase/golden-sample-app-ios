# frozen_string_literal: true

source "https://rubygems.org"

# gem "rails"

gem "cocoapods", "~> 1.15"
gem "fastlane"
gem "activesupport", "~> 7.0", "<= 7.2.2.1"
gem "slather"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
