Then(/^I verify the sectors "([^"]*)" page$/) do |page|
  banks = BanksPage.new(@driver, @data)

  case page
    when "banks"

    else
      p "case not matching"
  end
end