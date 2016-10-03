# Installation

## database configuration

- copy config/database.sample.yml to config/database.yml and configure to your liking
- create a db user `createuser -s -r treasure_hunt`
- now create and seed the database `rake db:setup db:seed`

## redis

- `brew install redis`
- `redis-server`

## server

- `rails server`

## configuration

you should take a look at `config/secrets.yml` and change everything to your liking.

interesting options:
- `api_token` which is a token that enables you to make request to the api


# Making requests

example:
```
curl -X GET -H "X-API-TOKEN: some-secret-token" "http://localhost:3000/api/v1/analytics.json?start_time=1-10-2016&end_time=10-10-2016"
```


