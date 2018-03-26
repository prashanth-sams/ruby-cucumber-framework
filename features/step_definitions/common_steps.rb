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
    when "sectors healthcare"
      @url_path="/#{ENV['LANG']}/sector/healthcare/sectorid/218/true"
    when "sectors real-estate-development"
      @url_path="/#{ENV['LANG']}/sector/real-estate-development/sectorid/44/"
    when "sectors hotels-and-tourism"
      @url_path="/#{ENV['LANG']}/sector/hotels-and-tourism/sectorid/36"
    when "sectors reits"
      @url_path="/#{ENV['LANG']}/sector/reits/sectorid/78"
  end
  @page = page
  @driver.navigate. to @base_url+@url_path
end


