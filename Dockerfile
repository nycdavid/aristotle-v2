FROM ruby:2.2.4-slim
# Debian config
RUN apt-get clean
RUN apt-get update
RUN apt-get -y install --fix-missing build-essential libpq-dev libqt4-dev \
    libqtwebkit-dev nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN gem install bundler
RUN bundle install
