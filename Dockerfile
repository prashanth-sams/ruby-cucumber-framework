#Dockerfile to build an image for running Selenium tests
FROM ubuntu:16.04
MAINTAINER Prashanth Sams

RUN apt-get update
RUN apt-get install -y curl vim git unzip xvfb libxi6 libgconf-2-4 x11vnc
RUN apt-get install -y gnupg2

RUN \curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby
#RUN /bin/bash -l -c "echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile"
RUN /bin/bash -l -c "echo "source /usr/local/rvm/scripts/rvm" >> ~/.bash_profile"
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Chrome browser to run the tests
ARG CHROME_VERSION=latest
RUN if [ ${CHROME_VERSION} = "latest" ]; then curl https://dl-ssl.google.com/linux/linux_signing_key.pub -o /tmp/google.pub && cat /tmp/google.pub | apt-key add -; rm /tmp/google.pub  && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list  && mkdir -p /usr/share/desktop-directories  && apt-get -y update && apt-get install -y google-chrome-stable; else curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && wget https://www.slimjet.com/chrome/download-chrome.php?file=lnx%2Fchrome64_$CHROME_VERSION.deb && dpkg -i download-chrome*.deb || true && apt-get install -y -f && rm -rf /var/lib/apt/lists/*;fi

# Disable the SUID sandbox so that chrome can launch without being in a privileged container
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome \
        && echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --no-sandbox --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome \
        && chmod 755 /opt/google/chrome/google-chrome

# Chrome Driver
ARG CHROME_DRIVER_VERSION=latest
RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE); else echo $CHROME_DRIVER_VERSION; fi) \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CD_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CD_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CD_VERSION /usr/bin/chromedriver

RUN if [ ${CHROME_DRIVER_VERSION} != "latest" ]; then mkdir -p /opt/selenium && curl http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -o /opt/selenium/chromedriver_linux64.zip && cd /opt/selenium; unzip /opt/selenium/chromedriver_linux64.zip; rm -rf chromedriver_linux64.zip; ln -fs /opt/selenium/chromedriver /usr/local/bin/chromedriver;fi

# Firefox browser to run the tests
ARG FIREFOX_VERSION=latest
RUN FIREFOX_DOWNLOAD_URL=$(if [ $FIREFOX_VERSION = "latest" ]; then echo "https://download.mozilla.org/?product=firefox-$FIREFOX_VERSION-ssl&os=linux64&lang=en-US"; else echo "https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2"; fi) \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install firefox \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && wget --no-verbose -O /tmp/firefox.tar.bz2 $FIREFOX_DOWNLOAD_URL \
  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

# Geckodriver
ARG GECKODRIVER_VERSION=latest
RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); else echo $GECKODRIVER_VERSION; fi) \
  && echo "Using GeckoDriver version: "$GK_VERSION \
  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
  && chmod 755 /opt/geckodriver-$GK_VERSION \
  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

#Clone Automation Test repository
RUN mkdir -p /usr/tests/ruby_cucumber
WORKDIR /usr/tests/ruby_cucumber
RUN git clone https://github.com/prashanth-sams/ruby_cucumber.git /usr/tests/ruby_cucumber

RUN /bin/bash -l -c "rvm gemset create selenium"
RUN /bin/bash -l -c "rvm use ruby-2.4.1@selenium"
RUN /bin/bash -l -c "bundle install"

#RUN /bin/bash -l -c "export DISPLAY=:20"
ENV DISPLAY :20
RUN /bin/bash -l -c "Xvfb :20 -screen 0 1366x768x16 &"

# Expose port 5920 to view display using VNC Viewer
EXPOSE 5920

RUN chmod 755 /usr/tests/ruby_cucumber/entrypoint.sh
ENTRYPOINT ["/usr/tests/ruby_cucumber/entrypoint.sh"]
