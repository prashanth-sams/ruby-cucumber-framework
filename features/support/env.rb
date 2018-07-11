require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'faker'
require 'rest-client'
require 'byebug'
require 'json'
require 'base64'
require 'allure-cucumber'
require 'allure-cucumber/dsl'
require 'parallel_tests'

include RSpec::Matchers

require File.dirname(__FILE__) + "/../helpers/utilities"


include ARGAAM

include AllureCucumber::DSL

# attach_file('title', file, true)


AllureCucumber.configure do |c|
  # c.output_dir = "/gen/allure-results"
  c.clean_dir  = false
end

class Cucumber::Core::Test::Step
  def name
    text
  end
end