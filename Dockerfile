FROM davidko/ruby-node:1.0.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./Gemfile /usr/src/app/Gemfile

RUN gem install bundler
RUN bundle install
