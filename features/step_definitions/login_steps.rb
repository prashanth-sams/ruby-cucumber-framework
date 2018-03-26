Then(/^I verify the home page as "([^"]*)" user/) do |page|
  home = HomePage.new(@driver, @data)

  case page
    when "bob"
      verify_element_present(home.sign_in, true)

    when "real"
      verify_element_present(home.user_profile, true)
      verify_element_present(home.user_display_name, true)

    else
      p "case not matching"
  end

  verify_element_present(home.popular_menu, true)
  verify_element_present(home.home_menu, true)
  verify_element_present(home.sectors_menu, true)
  verify_element_present(home.companies_menu, true)
  verify_element_present(home.tools_menu, true)
  verify_element_present(home.analysts_menu, true)
  verify_element_present(home.projects_menu, true)
  verify_element_present(home.indicators_tab, true)

end

When("I login as a real user") do
  home = HomePage.new(@driver, @data)

  wait_and_click(home.sign_in)
  wait_and_send(home.username, @data['LOGIN']['EMAIL'])
  wait_and_send(home.password, @data['LOGIN']['PASSWORD'])
  wait_and_click(home.submit)
end