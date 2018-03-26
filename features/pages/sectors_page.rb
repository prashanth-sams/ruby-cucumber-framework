class SectorsPage

  element :bank_statistics, {:css => ".financial-statement"}
  element :bank_index_chart, {:css => ".sector-chart-holder"}
  element :cement_statistics, {:css => ".financial-statement "}
  # element :insurance_index, {:css => ".charter "}

  element :index_chart, {:css => "#charter "}

  element :insurance_index, {:css => ".charter "}
  element :insurance_index, {:css => ".charter "}
  element :insurance_index, {:css => ".charter "}
  element :insurance_index, {:css => ".charter "}






  def initialize(driver, data)
    @driver = driver
    @data = data
  end
end