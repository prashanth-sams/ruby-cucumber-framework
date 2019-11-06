class GoogleHomePage

  # common
  element :search_input, {:css => "[name='q']"}

  def initialize(driver, data)
    @driver = driver
    @data = data
  end

end