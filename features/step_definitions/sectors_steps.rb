Then(/^I verify the sectors "([^"]*)" page$/) do |page|
  sectors = SectorsPage.new(@driver, @data)

  case page
    when "banks"
      expect(sectors.bank_statistics.displayed?).to be(true)
      expect(sectors.bank_index_chart.displayed?).to be(true)
      expect(@driver.title.include? "Bank").to be(true)
    when "cement"
      expect(sectors.cement_statistics.displayed?).to be(true)
      expect(@driver.title.include? "Cement news and prices in Saudi Arabia").to be(true)
    when "petrochemicals"
      expect(@driver.title.include? "Argaam Petrochemical index prices and products").to be(true)
    when "insurance"
      expect(sectors.index_chart.displayed?).to be(true)
      expect(@driver.title.include? "Insurance").to be(true)
    when "telecom"
      expect(sectors.index_chart.displayed?).to be(true)
      expect(@driver.title.include? "Telecom & IT").to be(true)
    when "healthcare"
      expect(sectors.index_chart.displayed?).to be(true)
      expect(@driver.title.include? "Health Care Services").to be(true)
    when "real-estate-development"
      expect(sectors.index_chart.displayed?).to be(true)
      expect(@driver.title.include? "Real Estate Development").to be(true)
    when "hotels-and-tourism"
      expect(@driver.title.include? "Hotels & Tourism").to be(true)
    when "reits"
      expect(sectors.index_chart.displayed?).to be(true)
      expect(@driver.title.include? "REITS").to be(true)

    else
      p "case not matching"
  end
end