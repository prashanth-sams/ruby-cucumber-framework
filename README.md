### Build Docker image

```
docker build -t <image_name> .
```

### Docker container 
```
docker run -d -t <image_name>
```

Test runner
----------
##### Rake runner

```
rake spec
```

##### Xvfb headless mode

```
source /usr/local/rvm/scripts/rvm
 
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
 
cucumber features/scenario/demo/google.feature
```

##### Browser headless mode

```
source /usr/local/rvm/scripts/rvm
cucumber features/scenario/demo/google.feature MODE=headless
```