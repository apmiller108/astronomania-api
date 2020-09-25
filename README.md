[![Build Status](https://travis-ci.org/apmiller108/astronomania-api.svg?branch=master)](https://travis-ci.org/apmiller108/astronomania-api)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/b66599714f82423b8a1f374e79476f27)](https://www.codacy.com/app/apmiller108/astronomania-api?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=apmiller108/astronomania-api&amp;utm_campaign=Badge_Grade)
# Astronomania Ruby on Rails API

## API Documentation
### Postman Public Docs
* See the [Postman public docs site](https://documenter.getpostman.com/view/264251/astronomania/6mxaxAK) 
  for documentation concerning using the API.
  
## Astronomy Data

### NASA Public APIs
* Currently all data comes from [NASA Open APIs](https://api.nasa.gov/).  Daily background jobs are run populate the data base with data.

## Development

### Docker
This app is dockerized soley for development environment normalization. It's not required to do development, it's just here for convenience.

* `docker-compose build` - build the containerized app
* `docker-compose up` - start the app on localhost:3000

### Docker Compose
Prefix commands with `docker-compose run app` to run them agaist the application 
container. For example:

* `docker-compose run --rm web rails console` - runs the rails console
* `docker-compose run --rm web bash` - runs the shell

### Rspec
* `docker-compose run --rm web rspec` - run rpsec tests. Alternatively, open a bash
  prompt (see above) and run `rspec`.

### Postgres
* `docker-compose run --rm web rake db:setup` - Set up and seed database.
* NOTE: the `host` value must be set to `postgres` to work with docker
* `docker-compose run --rm web rake sample_data:add` - to add all sample data to the database.
  Sample data is also split into groups, so if you just want users you can run
  `rake sample_data:add_users`. See [lib/tasks/sample/add_sample_data.rake](https://github.com/apmiller108/astronomania-api/blob/master/lib/tasks/sample/add_sample_data.rake) for all
  available `sample_data` tasks.

### Debugging with Pry and Docker
* `docker attach astronomania-api_web_1` - attach to container stdin/out using the id from the above step.
* `crtl p ctrl q` to exit debugging without stopping the container.

## Deployment

### Heroku
* Deployments to staging are automaticly made from the master branch.
* Deployment to production and performed via Heroku pipeline promotion
  mechanism.
  
### AWS Lambda, AWS CloudWatch, and Background Jobs
* Background job processing is handled via `sidekiq`
* Jobs are started by sending `POST` request to `/admin/jobs` with the `job_type` in the payload. These requests must
  be authenticated by an Admin user.
* Jobs are scheduled using AWS CloudWatch events and AWS Lambda.  Lambda functions are kept in [/aws_lambda_functions](https://github.com/apmiller108/astronomania-api/tree/master/lambda_functions).

## Client App Repos
* [Astronomania Web App](https://github.com/apmiller108/astronomania)
