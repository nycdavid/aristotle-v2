FROM davidko/ruby-node:1.0.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN gem install bundler
RUN apt-get -y install npm
RUN npm install
RUN bundle install
