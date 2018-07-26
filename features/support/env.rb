require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'faker'
require 'rest-client'
require 'byebug'
require 'json'
require 'base64'
require 'report_builder'

include RSpec::Matchers

require File.dirname(__FILE__) + "/../helpers/utilities"
include ARGAAM