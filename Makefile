build:
	DOCKER_API_VERSION=1.23 docker build \
	-t davidko/aristotle:1.0.0 \
	.

prep-db:
	DOCKER_API_VERSION=1.23 docker run \
	-d \
	--name aristotle-test-db \
	postgres:9.5.4

migrate:
	DOCKER_API_VERSION=1.23 docker run \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "bundle exec rake db:create && bundle exec rake db:migrate"

tests:
	DOCKER_API_VERSION=1.23 docker run \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "bundle exec rspec spec/"

shell:
	docker run \
	--rm \
	-it \
	--link aristotle-test-db \
	-v $(shell pwd):/usr/src/app/ \
	davidko/aristotle:1.0.0 \
	bash
