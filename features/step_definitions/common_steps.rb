Given(/^I navigate to "([^"]*)" page$/) do |page|
  case page
    when "home"
      @url_path="/#{ENV['LANG']}"
    when "sectors banks"
      @url_path="/#{ENV['LANG']}/sector/bank/sectorid/4"
    when "sectors cement"
      @url_path="/#{ENV['LANG']}/sector/cement/sectorid/6"
    when "sectors petrochemicals"
      @url_path="/#{ENV['LANG']}/sector/petrochemicals/sectorid/33"
    when "sectors insurance"
      @url_path="/#{ENV['LANG']}/sector/insurance/sectorid/2/"
    when "sectors telecom"
      @url_path="/#{ENV['LANG']}/sector/telecom/sectorid/52"
  end
  @page = page
  @driver.navigate. to @base_url+@url_path
end


