pg:
	docker run --name aris-dev -d -p 5432:5432 postgres:9.6.1-alp-tz
deploy:
	git push origin master && git push heroku master
