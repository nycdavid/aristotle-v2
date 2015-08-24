FROM ruby:2.2.3-slim
MAINTAINER Yung Hwa Kwon <yung.kwon@damncarousel.com>

RUN apt-get update && apt-get install -y \
	build-essential \
	libxslt-dev libxml2-dev \
	libpq-dev \
	libqt4-dev \
	git \
	nodejs \
	&& ln -s /usr/bin/nodejs /usr/local/bin/node \
	&& apt-get install -y npm \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# uid 1001 is my local user's uid
RUN adduser --disabled-password --uid 1001 --gecos '' app \
	&& echo "app ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
	&& mkdir -p /home/app/src \
	&& chown -R app:app /home/app/src \
	&& echo "gem: --no-rdoc --no-ri" > /etc/gemrc

ENV GEM_HOME /home/app/.bundle
ENV BUNDLE_APP_CONFIG $GEM_HOME
ENV PATH $GEM_HOME/bin:$PATH

USER app
WORKDIR /home/app/src
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY ./docker-entrypoint /docker-entrypoint
ENTRYPOINT [ "/docker-entrypoint" ]
CMD [ "rails", "server", "-b", "0.0.0.0" ]

EXPOSE 3000
VOLUME [ "/app" ]

