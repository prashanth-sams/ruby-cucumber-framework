Before do |scenario|
  setup

  case ENV['BROWSER'].downcase
  when "chrome"
    $logger.debug("opening chrome browser...") if $logger
    launch_driver_chrome
  when "firefox"
    $logger.debug("opening firefox browser...")
    launch_driver_firefox
  else
    p "Browser not mentioned"
  end

end

After do |scenario|
  if scenario.failed?
    $logger.debug("scenario: #{scenario} FAILED") if $logger
    begin
      Dir.mkdir("./reports/screenshots") unless Dir.exists?("./reports/screenshots")
      file = "#{scenario.name.gsub(" ","_").gsub(/[^0-9A-Za-z_]/, "")}.png"
      driver.save_screenshot("./reports/screenshots/#{file}")
    rescue
      p "*** Could not take failed scenario screenshot ***"
    end
  end
  quit_driver
end

at_exit do
  ENV['TITLE'] = "TEST AUTOMATION REPORT" if ENV['TITLE'].nil?
  begin
    report_file = File.absolute_path("report.html", "reports")
    doc = File.read(report_file)
  rescue
    report_file = File.absolute_path("test_report.html", "reports")
    doc = File.read(report_file)
  end
  new_doc = doc.sub("Cucumber Features", "#{ENV['TITLE']}")
  File.open(report_file, "w") {|file| file.puts new_doc}
end

def driver
  @driver
end

def quit_driver
  @driver.quit
end

def setup
  # file logs
  logs if ENV['LOGGER'] && ENV['LOGGER'].upcase == "ON"

  # Load test data into @data variable
  @data = YAML.load_file(File.dirname(__FILE__) + "/../../data/data.yml")

  # Default BROWSER and DEVICE
  ENV['BROWSER'] = "chrome" if ENV['BROWSER'].nil?
  # Base URL
  @base_url = @data['PROD_URL']
end
