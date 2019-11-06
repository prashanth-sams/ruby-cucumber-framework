Then(/^I verify the sectors "([^"]*)" page$/) do |page|
  sectors = SectorsPage.new(@driver, @data)

  case page
    when "banks"
      expect(sectors.bank_statistics.displayed?).to eq(true)
      expect(sectors.bank_index_chart.displayed?).to eq(true)
      expect(@driver.title.include? "Bank").to be(true)

    else
      p "case not matching"
  end
end