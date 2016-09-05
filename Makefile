build:
	docker build \
	-t davidko/aristotle:1.0.0 \
	.

prep-db:
	docker run \
	-d \
	--name aristotle-test-db \
	postgres:9.5.4

migrate:
	docker run \
	-v $(shell pwd)/config/database.docker.dev.yml:/usr/src/app/config/database.yml \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "bundle exec rake db:create && bundle exec rake db:migrate"

tests:
	docker run \
	-v $(shell pwd)/config/database.docker.dev.yml:/usr/src/app/config/database.yml \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "ln -s /usr/bin/nodejs /usr/bin/node && bundle exec rspec spec/"

shell:
	docker run \
	--rm \
	-it \
	--link aristotle-test-db \
	-v $(shell pwd)/config/database.docker.dev.yml:/usr/src/app/config/database.yml \
	davidko/aristotle:1.0.0 \
	bash
