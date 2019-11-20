### Build Docker image
```bash
docker build -t <image_name> .
```

### Docker container 
```bash
docker run -d -t <image_name>
```

Test runner
----------
##### Rake runner
```bash
rake spec
```

##### Allure report
```bash
rake allure
allure generate reports/allure-results/ --clean && allure open
```

##### Cross Browser
```bash
# chrome
rake allure BROWSER=chrome

# firefox
rake allure BROWSER=firefox
```

##### Logs
```bash
rake allure BROWSER=chrome LOGGER=ON
```

##### Xvfb headless mode
```bash
source /usr/local/rvm/scripts/rvm
 
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
 
cucumber features/scenario/demo/google.feature
```

##### Browser headless mode
```bash
source /usr/local/rvm/scripts/rvm
cucumber features/scenario/demo/google.feature MODE=headless
```