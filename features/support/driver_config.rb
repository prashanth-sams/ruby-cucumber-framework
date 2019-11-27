def launch_driver_firefox
  if ENV['MODE'] && ENV['MODE'].downcase=='headless'
    options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
    @driver = Selenium::WebDriver.for :firefox, options: options
    target_size = Selenium::WebDriver::Dimension.new(1600, 1268)
    @driver.manage.window.size = target_size
  else
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.window.maximize
  end

  @driver.manage.timeouts.implicit_wait = 60
  @driver.manage.timeouts.page_load = 60
end

def launch_driver_chrome
  if ENV['MODE'] && ENV['MODE'].downcase=='headless'
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')

    if ENV['DOCKER'] && ENV['DOCKER'].downcase == 'on'
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(options)
      @driver = Selenium::WebDriver.for :remote, :url => "http://0.0.0.0:4444/wd/hub", desired_capabilities: caps
    else
      @driver = Selenium::WebDriver.for :chrome, options: options
    end

    max_width, max_height = driver.execute_script("return [window.screen.availWidth, window.screen.availHeight];")
    @driver.manage.window.resize_to(max_width, max_height)

  else
    if ENV['DOCKER'] && ENV['DOCKER'].downcase == 'on'
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
      @driver = Selenium::WebDriver.for :remote, :url => "http://0.0.0.0:4444/wd/hub", desired_capabilities: caps
    else
      @driver = Selenium::WebDriver::Driver.for(:chrome)
    end

    @driver.manage.window.maximize
  end

  @driver.manage.timeouts.implicit_wait = 60
  @driver.manage.timeouts.page_load = 60
end

def logs
  now = (Time.now.to_f * 1000).to_i
  $logger = Logger.new(STDOUT)
  $logger.datetime_format = '%Y-%m-%d %H:%M:%S'

  $logger = Logger.new(File.new("logs/test_#{now}.log", 'w'))
  $logger.level = Logger::DEBUG
end