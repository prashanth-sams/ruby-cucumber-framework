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
    begin
      encoded_img = driver.screenshot_as(:base64)
      embed("#{encoded_img}", "image/png;base64")
    rescue
      p "*** Could not take failed scenario screenshot ***"
    end
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
