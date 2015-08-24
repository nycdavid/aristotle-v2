# aristotle

> v2


## Getting started with Docker

Build the container.

    docker build --rm -t aristotle-v2 .

*Assumes you are within the repo's root directory, where the Dockerfile lives.*


Run the container.

    docker run \
        -v $(pwd):/app -p 3000:3000 --link postgres:postgres \
        --rm \
        -it aristotle-v2 rails server


Because the app runs in it's own isolated container it will always run on port
3000. But if you need to expose it locally at another port, define that through
Docker's `-p` directive instead of passing in a `-p` with the `rails server`
command.

    ... aristotle-v2 rails server -p 4000         # <- bad
    ... -p 4000:3000 aristotle-v2 rails server    # <- good


Postgres will require it's own container, which can be automatically run with:

    docker run -e POSTGRES_PASSWORD=astrongpassword \
        -v /var/lib/postgresql/data:/var/lib/postgresql/data \
        --publish 127.0.0.1:5432:5432 \
        --name postgres \
        -Pt -d \
        --rm postgres

You can omit the `-v` volume mount directives if you plan to use the postgres
image in an ephemeral fashion.

---

__Note:__ You must create the database before the server will start properly.

    ./docker-run bundle exec rake db:create
    ./docker-run bundle exec rake db:migrate

The `./docker-run` command provides a wrapper around the verbose `docker run`
command above to pass commands into the docker image. This should be the
preferred method of getting at the rails app and other internals.


---

Go to:

    http://localhost:3000

