require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:spec) do |features|
	features.cucumber_opts = "features/scenarios/**/** --format html --out=reports/test_report.html --tags '@search' --format rerun --out reports/rerun.txt -f pretty -f json -o reports/cucumber.json"
end

Cucumber::Rake::Task.new(:allure) do |features|
	features.cucumber_opts = "features/scenarios/**/** -p allure"
end