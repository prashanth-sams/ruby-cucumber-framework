module API

  def logs_cleaner
    Dir.mkdir("./logs") unless File.exist?("./logs")
    Dir["./logs/*.log"].map {|junk_file| File.delete(junk_file)}
  end

  def wait_for_element(locator, time=20)
    wait = Selenium::WebDriver::Wait.new(:timeout => time)
    if locator.class == Hash
      wait.until { @driver.find_element(locator).displayed? }
    else
      wait.until { locator.displayed? }
    end
  end

  def wait_for_elements(locator, secs)
    wait = Selenium::WebDriver::Wait.new(timeout: secs)
    begin
      if locator.class == Hash
        wait.until { @driver.find_elements(locator).size!=0 }
      else
        wait.until { locator.size!=0 }
      end
    rescue
      return false
    end
    return true
  end

  def accept_alert
    @driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
  end

  def reject_alert
    @driver.switch_to.alert.dismiss rescue Selenium::WebDriver::Error::NoAlertOpenError
  end

  def wait_for_ajax(timeout=15)
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
    begin
      wait.until { @driver.execute_script("return jQuery.active").to_i == 0 }
      wait.until { @driver.execute_script('return document.readyState').eql?('complete') }
        # wait.until { (@driver.execute_script("return jQuery.active").to_i == 0) && (@driver.execute_script("return window.jQuery != undefined")) }
        # p @driver.execute_script('return document.readyState')
        # p @browser.execute_script("return typeof jQuery")
    rescue Selenium::WebDriver::Error::JavascriptError => jquery_error
      puts ReferenceError
      puts jquery_error
    rescue Selenium::WebDriver::Error::UnknownError => unknown_error
      puts unknown_error
    rescue
      # wait.until { @driver.execute_script('return document.readyState').eql?('complete') }
      puts "skipped ajax wait"
    end
  end

  def page_refresh
    @driver.navigate.refresh
  end

  def select_random_value_from_dropdown(ele)
    wait_for_element(ele)
    select = Selenium::WebDriver::Support::Select.new(ele)
    options=select.options
    options.shift
    select.select_by(:text, options[rand(options.size-1)].text)
  end

  def select_option_from_dropdown(ele, by, val)
    wait_for_element(ele)
    Selenium::WebDriver::Support::Select.new(ele).select_by(by.to_sym, val)
  end

  def wait_for_loader_to_complete(time)
    wait = Selenium::WebDriver::Wait.new(:timeout => time)
    wait.until { @driver.find_elements(css: '.block-spinner-bar').size==0 }
  end

  def scroll_to_page(x, y)
    @driver.execute_script("window.scrollTo(#{x},#{y})")
  end

  def wait_for_present(locator, secs=10)
    wait = Selenium::WebDriver::Wait.new(timeout: secs)
    if locator.class == Hash
      wait.until { @driver.find_element(locator).size!=0 }
    else
      wait.until { locator.size!=0 }
    end
  end

  def press_button(key)
    @driver.action.send_keys(:"#{key}").perform
  end

  def wait_until_disappears(locator, secs=10)
    wait = Selenium::WebDriver::Wait.new(timeout: secs)
    begin
      if locator.class == Hash
        wait.until { @driver.find_elements(locator).size==0 }
      else
        wait.until { locator.size==0 }
      end
    rescue
      # return false
    end
    return true
  end

  def element(element_name, locator, error=true)
    send(:define_method, element_name) do
      wait = Selenium::WebDriver::Wait.new(:timeout => 0.5)
      begin
        wait.until { @driver.find_element(locator) }
      rescue Selenium::WebDriver::Error::TimeOutError
        if error
          raise "Could not find element using '#{locator.first.key}=#{locator.first.key}' strategy"
        else
          return false
        end
      end
    end
  end

  def elements(element_name, locator, error=false)
    send(:define_method, element_name) do
      wait = Selenium::WebDriver::Wait.new(:timeout => 0.5)
      begin
        wait.until { !@driver.find_elements(locator).empty? }
        @driver.find_elements(locator)
      rescue Selenium::WebDriver::Error::TimeOutError
        if error
          raise "Could not find any elements using '#{locator.first.key}=#{locator.first.key}' strategy"
        else
          return []
        end
      end
    end
  end

  def verify_text_present(element, text, option=true)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element.size!=0 }
    expect(element.text.include? text).to be(option)
  end

  def verify_pagesource(text, option=true)
    expect(@driver.page_source.include? text).to be(option)
  end

  def verify_element_visible(element, option=true)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element.displayed? }
    expect(element.displayed?).to be(option)
  end


  def verify_elements_present(element, option=true)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element.size!=0 }
    expect(element.size!=0).to be(option)
  end

  def verify_element_present(element, timeout=10)
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
    wait.until { element.displayed? }
  end

  def wait_until(assert, timeout=15)
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
    wait.until { assert }
  end

  def select_and_wait(element, text)
  	element.select(text)
  	wait_for_ajax_requests
  end

  def select_by_value(name, value)
  custom_css = "[name='#{name}'] > option[value='#{value}']"
  page.find(:css, custom_css).click
  wait_for_ajax_requests
  end

  def select_by_position(name, position)
  custom_xpath = "(//*[@name='#{name}']/option[not(@selected)])[#{position}]"
  page.find(:xpath, custom_xpath).click
  wait_for_ajax_requests
  end

  def wait_and_click(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element }
    element.click
  end

  def wait_and_send(element, text)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element }
    element.clear
    element.send_keys text
  end

end