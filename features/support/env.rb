require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'faker'
require 'byebug'
require 'json'

include RSpec::Matchers

require File.dirname(__FILE__) + "/../helpers/utilities"
include API