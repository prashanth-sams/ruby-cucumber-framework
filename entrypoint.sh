#!/bin/bash
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
x11vnc -passwd TestVNC -display :20 -N -forever &

source /usr/local/rvm/scripts/rvm

# clean the existing repo
cd /usr/tests/ && rm -rf ruby_cucumber/

# clone and install new libs if available
git clone https://github.com/prashanth-sams/ruby_cucumber.git /usr/tests/ruby_cucumber
cd /usr/tests/ruby_cucumber && gem install bundler && bundle install

# cmd to run tests
cucumber features/scenarios/demo/google.feature MODE=headless
wait