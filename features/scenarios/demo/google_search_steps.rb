Given("I navigate to Google page") do
  @driver.get "https://www.google.ae/"
end

Then("I verify the goole home page") do
  expect(@driver.find_element(:css => "#lst-ib").displayed?).to be(true)
end

When(/^I search for keyword "([^"]*)"/) do |keyword|
  @driver.find_element(:css => "#lst-ib").send_keys keyword
  @driver.action.send_keys(:enter).perform
end

Then("I verify the search result") do
  expect(@driver.page_source.include? "Prashanth Sams").to be(true)
end
