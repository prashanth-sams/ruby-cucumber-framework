require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:website_desktop) do |features|
	features.cucumber_opts = "features/scenarios/baseline --format html --out=reports/website_#{ENV['COUNTRY']}_#{ENV['PAGE']}_#{ENV['SECTION']}_report.html --tags '@#{ENV["COUNTRY"].to_s.downcase} and @#{ENV["PAGE"].to_s.downcase} and @#{ENV["SECTION"].to_s.downcase}' --format rerun --out #{ENV['COUNTRY'].to_s.downcase}_rerun.txt  -f pretty -f json -o #{ENV['COUNTRY']}_#{ENV['PAGE']}_#{ENV['SECTION']}_cucumber.json"
end