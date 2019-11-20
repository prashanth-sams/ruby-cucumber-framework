Then("I verify the Google home page") do
  home = GoogleHomePage.new(@driver, @data)
  expect(home.search_input.displayed?).to be(true)
end

When(/^I search for keyword "([^"]*)"/) do |keyword|
  home = GoogleHomePage.new(@driver, @data)

  $logger.debug("sending input as #{keyword} for google search") if $logger
  home.search_input.send_keys keyword
  @driver.action.send_keys(:enter).perform
end

Then("I verify the search result") do
  expect(@driver.page_source.include? "Prashanth Sams").to eq(true)
end
