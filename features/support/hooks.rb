Before do |scenario|
  setup

  case ENV['BROWSER'].downcase
    when "chrome"
      launch_driver_chrome
    when "firefox"
      launch_driver_firefox
    else
      p "Browser not mentioned"
  end

end

After do |scenario|
  if scenario.failed? and ENV['BROWSER'].downcase != "api"
    screenshot = "#{scenario.name}"
    begin
      # attach_file(screenshot, %{#{screenshot}.png})
      attach_file(screenshot, File.open(%{#{screenshot}.png}))
      # embed(screenshot, File.new(driver.save_screenshot(File.join(Dir.pwd, "#{screenshot}.png"))), true)
      # embed(screenshot, File.new(driver.save_screenshot(File.join(Dir.pwd, "#{screenshot}.png"))), true)
      # AllureCucumber::DSL.attach_file(screenshot, File.open(%{#{screenshot}.png}))
      # AllureCucumber::DSL.attach_file(screenshot, %{#{screenshot}.png})
      # AllureCucumber::Formatter.embed(%{#{screenshot}.png}, 'image/png', screenshot)

    rescue
      p "*** Could not take failed scenario screenshot ***"
    end

    # begin
    #   attach_file(screenshot, File.new(
    #       driver.save_screenshot(
    #           File.join(Dir.pwd, "#{screenshot}.png"))), true)
    # rescue
    #   p "*** Could not take failed scenario screenshot ***"
    # end
  end
  quit_driver
end

at_exit do
  ENV['TITLE'] = "ARGAAM AUTOMATION REPORT" if ENV['TITLE'].nil?
  begin
    report_file = File.absolute_path("report.html", "reports")
    doc = File.read(report_file)
  rescue
    report_file = File.absolute_path("argaam_report.html", "reports")
    doc = File.read(report_file)
  end
  new_doc = doc.sub("Cucumber Features", "#{ENV['TITLE']}")
  File.open(report_file, "w") { |file| file.puts new_doc }
end

def driver
  @driver
end

def quit_driver
  @driver.quit
end

def setup
  # Load test data into @data variable
  @data = YAML.load_file(File.dirname(__FILE__) + "/../../data/data.yml")
  # Default COUNTRY
  ENV['LANG'] = "en" if ENV['LANG'].nil?
  # Default BROWSER and DEVICE
  ENV['BROWSER'] = "chrome" if ENV['BROWSER'].nil?
  # Base URL
  @base_url = @data['PROD_URL']
end
