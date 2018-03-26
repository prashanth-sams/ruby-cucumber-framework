class HomePage

  # common
  element :popular_menu, {css: "#popularMenu"}
  element :home_menu, {css: "#mnu_Home"}
  element :sectors_menu, {css: "#mnu_Sectors"}
  element :companies_menu, {css: "#mnu_Companies"}
  element :tools_menu, {css: "#mnu_Tools"}
  element :analysts_menu, {css: "#mnu_Analysts"}
  element :projects_menu, {css: "#mnu_Projects"}
  element :indicators_tab, {css: "#frmIndicatorsData"}

  # login
  element :sign_in, {css: ".top .login"}
  element :username, {css: "#UserName"}
  element :password, {css: "#pass"}
  element :submit, {css: "#btnSubmit"}

  # real user
  element :user_profile, {css: ".user-profile"}
  element :user_display_name, {css: "#profileDisplayName"}

  def initialize(driver, data)
    @driver = driver
    @data = data
  end

end