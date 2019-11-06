Given(/^I navigate to Google "([^"]*)" page$/) do |page|
  case page
    when "home"
      @url_path="/"
    when "sectors banks"
      @url_path="/#{ENV['LANG']}/sector/bank/sectorid/4"
  end
  @page = page
  @driver.navigate. to @base_url+@url_path
end


