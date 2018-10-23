#Dockerfile to build an image for running Selenium Ruby tests
FROM prashanthsams/selenium-ruby
MAINTAINER Prashanth Sams

#Clone Automation Test repository to get the entrypoint
RUN mkdir -p /usr/tests/ruby_cucumber
WORKDIR /usr/tests/ruby_cucumber
RUN git clone https://github.com/prashanth-sams/ruby_cucumber.git /usr/tests/ruby_cucumber

COPY ./entrypoint.sh /usr/tests/
RUN rm -rf *

RUN chmod 755 /usr/tests/entrypoint.sh
ENTRYPOINT ["/usr/tests/entrypoint.sh"]