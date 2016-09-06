build:
	sudo docker build \
	-t davidko/aristotle:1.0.0 \
	.

prep-db:
	sudo docker run \
	-d \
	--name aristotle-test-db \
	postgres:9.5.4

migrate:
	sudo docker run \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "mv config/database.sample.yml config/database.yml && bundle exec rake db:create && bundle exec rake db:migrate"

tests:
	sudo docker run \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash -c "bundle exec rspec spec/"

shell:
	sudo docker run \
	--rm \
	-it \
	--link aristotle-test-db \
	davidko/aristotle:1.0.0 \
	bash
