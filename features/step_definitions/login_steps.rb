Then(/^I verify the home page as "([^"]*)" user/) do |page|
  home = HomePage.new(@driver, @data)

  case page
    when "bob"
      expect(home.sign_in.displayed?).to be(true)

    when "real"
      expect(home.user_profile.displayed?).to be(true)
      expect(home.user_display_name.displayed?).to be(true)

    else
      p "case not matching"
  end

  expect(home.popular_menu.displayed?).to be(true)
  expect(home.home_menu.displayed?).to be(true)
  expect(home.sectors_menu.displayed?).to be(true)
  expect(home.companies_menu.displayed?).to be(true)
  expect(home.tools_menu.displayed?).to be(true)
  expect(home.analysts_menu.displayed?).to be(true)
  expect(home.projects_menu.displayed?).to be(true)

end

When("I login as a real user") do
  home = HomePage.new(@driver, @data)

  wait_and_click(home.sign_in)
  wait_and_send(home.username, @data['LOGIN']['EMAIL'])
  wait_and_send(home.password, @data['LOGIN']['PASSWORD'])
  wait_and_click(home.submit)
end