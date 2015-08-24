FROM ruby:2.2.3-slim
MAINTAINER Yung Hwa Kwon <yung.kwon@damncarousel.com>

RUN apt-get update && apt-get install -y \
	build-essential \
	libxslt-dev libxml2-dev \
	libpq-dev \
	libqt4-dev \
	git \
	nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc \
	&& gem install bundler && bundle install \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./docker-entrypoint /docker-entrypoint
ENTRYPOINT [ "/docker-entrypoint" ]
CMD [ "rails", "server", "-b", "0.0.0.0" ]

EXPOSE 3000
VOLUME [ "/app" ]

