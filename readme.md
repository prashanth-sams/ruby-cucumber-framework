```
$ brew untap qameta/allure
$ brew update
$ brew install allure 
```
```
gem 'allure-cucumber'
```
```
require 'allure-cucumber'
 
include AllureCucumber::DSL  
 
 
AllureCucumber.configure do |c|   
  c.output_dir = "/output/dir"   
  c.clean_dir  = false 
end
```
```
cucumber features/scenarios/desktop/**/*.feature --format AllureCucumber::Formatter
```

```
allure generate gen/allure-results/ --clean
allure open
 
Or
 
allure serve gen/allure-results
```