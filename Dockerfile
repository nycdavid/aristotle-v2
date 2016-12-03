FROM ruby:2.2.4-alpine

RUN apk update && apk add \
  git g++ make libxml2-dev libxslt-dev qt-dev nodejs tzdata postgresql-dev libpq

ADD Gemfile* tmp/
WORKDIR /tmp
RUN gem install bundler && \
  bundle config build.nokogiri \
  --use-system-libraries && \
  bundle install

RUN apk remove \
  postgresql

RUN mkdir -p /app
WORKDIR /app

ADD . ./

EXPOSE 3000

CMD ["foreman", "start"]
