#!/bin/bash
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
x11vnc -passwd TestVNC -display :20 -N -forever &

source /usr/local/rvm/scripts/rvm

cd /usr/tests/ && rm -rf ruby_cucumber/
git clone https://github.com/prashanth-sams/ruby_cucumber.git /usr/tests/ruby_cucumber
cd /usr/tests/ruby_cucumber
gem install bundler && bundle install

cucumber features/scenarios/demo/google.feature MODE=headless
cd /usr/tests/ && rm -rf *
wait