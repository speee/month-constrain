$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'month/constrain'
require 'bundler/setup'
Bundler.require
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
