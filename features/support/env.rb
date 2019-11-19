require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'byebug'
require 'allure-cucumber'

include RSpec::Matchers

require File.dirname(__FILE__) + "/../helpers/utilities"
include API


Allure.configure do |c|
  c.results_directory = "/reports/allure"
  c.clean_results_directory = true
  c.logging_level = Logger::INFO
end