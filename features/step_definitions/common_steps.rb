Given(/^I navigate to Google (home|serp) page/) do |page|
  case page
  when "home"
    @url_path="/"
  else
    p "case not matching"
  end
  @driver.navigate.to @base_url+@url_path
end