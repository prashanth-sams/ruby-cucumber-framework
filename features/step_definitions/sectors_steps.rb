Then(/^I verify the sectors "([^"]*)" page$/) do |page|
  sectors = SectorsPage.new(@driver, @data)

  case page
    when "banks"
      verify_element_present(sectors.bank_statistics)
      verify_element_present(sectors.bank_index_chart)
      expect(@driver.title.include? "Bank").to be(true)
    when "cement"
      verify_element_present(sectors.cement_statistics)
      expect(@driver.title.include? "Cement news and prices in Saudi Arabia").to be(true)
    when "petrochemicals"
      expect(@driver.title.include? "Argaam Petrochemical index prices and products").to be(true)
    when "insurance"
      verify_element_present(sectors.index_chart)
      expect(@driver.title.include? "Insurance").to be(true)
    when "telecom"
      verify_element_present(sectors.index_chart)
      expect(@driver.title.include? "Telecom & IT").to be(true)
    when "healthcare"
      verify_element_present(sectors.index_chart)
      expect(@driver.title.include? "Health Care Services").to be(true)
    when "real-estate-development"
      verify_element_present(sectors.index_chart)
      expect(@driver.title.include? "Real Estate Development").to be(true)
    when "hotels-and-tourism"
      expect(@driver.title.include? "Hotels & Tourism").to be(true)
    when "reits"
      verify_element_present(sectors.index_chart)
      expect(@driver.title.include? "REITS").to be(true)

    else
      p "case not matching"
  end
end