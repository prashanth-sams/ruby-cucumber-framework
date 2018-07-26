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

  @driver.manage.timeouts.implicit_wait = 10
  @driver.manage.timeouts.page_load = 20
end

def launch_driver_chrome

  if ENV['MODE'] && ENV['MODE'].downcase=='headless'
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @driver = Selenium::WebDriver.for :chrome, options: options

    max_width, max_height = driver.execute_script("return [window.screen.availWidth, window.screen.availHeight];")
    p max_width
    p max_height
    @driver.manage.window.resize_to(max_width, max_height)

  else
    @driver = Selenium::WebDriver::Driver.for(:chrome)
    @driver.manage.window.maximize
  end

  @driver.manage.timeouts.implicit_wait = 10
  @driver.manage.timeouts.page_load = 20
end