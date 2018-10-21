#Dockerfile to build an image for running Selenium Ruby tests
FROM prashanthsams/selenium-ruby
MAINTAINER Prashanth Sams

#Clone Automation Test repository
RUN mkdir -p /usr/tests/ruby_cucumber
WORKDIR /usr/tests/ruby_cucumber
RUN git clone https://github.com/prashanth-sams/ruby_cucumber.git /usr/tests/ruby_cucumber

RUN /bin/bash -l -c "gem install bundler && bundle install"

RUN chmod 755 /usr/tests/ruby_cucumber/entrypoint.sh
ENTRYPOINT ["/usr/tests/ruby_cucumber/entrypoint.sh"]