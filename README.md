# JWT authentication

This project is a dockerized RESTfull API, versioned and with good security and performance practices that will ensure easier evolution and maintenance in the future. At the moment there is only one endpoint which is a JWT authentication.

## Starting

The entire project was built on top of Docke and Docker Compose. These are the only dependencies that will be needed to run the project.
[Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) 
[Docker Composer](https://docs.docker.com/compose/install/)

### How to run it

With the dependencies installed, execute the command below in the terminal to copy the environment variables.

```sh
cp .env{-example,}
```

Inside the `.env` file that was generated there is an environment variable called` TEST_ENV_NUMBER` it represents the number of cores that will be used to run the test in RSpec, for example, if your machine is a quad core you can put the value 4 and tests will be divided equally for the four cores.

With the dependencies installed, run the commands below to download the images, upload the containers and configure the database.

```sh
docker-compose run --rm web bundle exec rails db:setup
docker-compose up
```

Ready! Project ready for local testing! \o/

### Testing functionality

To test it will be necessary to use some software to make requests. In this example we will explain how to use Postman, but any one of your choice can be used.

To be authenticate make a request to the endpoint below with the same body, this user was created with seeds, but you can create others in the Rails console and test the authentication too, the necessary data is email and passoword, another suggestion is to put the invalid email or password.

```
POST

localhost:3001/login

Body:
{
	"email": "test@pipefy.com",
	"password": 12345678
}

Resultado:
{
    "access_token": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MDczNjI5ODh9.Ih4fXZChGnZffjyD1cTE9IcVq13-olpyqSIYX7I1mSPHI5bBlUlObrNmhPyg5N7e7fE9i4NQfdnRZCNTYVej1w"
}
```

This project is running on port 3001.

## Running the tests
This project has a more performative test suite than usual through Spring and parallel tests. To run the normal tests use the command below:

```
docker-compose exec web rspec
```

However, you can run this same tests with Spring and parallelized, follow the commands below to create the test banks and run the tests:

```
docker-compose exec web rake parallel:create
docker-compose exec web rake parallel:prepare
docker-compose exec spring bundle exec spring parallel_rspec spec
```

The coverage is configured for parallelized tests and there is a Spring container just to run the tests.

### Code quality
As in any other project, quality is extremely important for its maintenance and evolution, therefore, it was configured with several gems that guarantee the best practices, they are: Fasterer, RubyCritic, Rubocop, Brakeman, Bundler Audit and Rails Best Practices .

```
brakeman --quiet --run-all-checks --ensure-latest --no-pager
bundle exec bundle-audit
rubycritic
fasterer
rails_best_practices . -c config/rails_best_practices.yml
rubocop --require rubocop-performance -a
```

## Author

**Vinicius Camboim**