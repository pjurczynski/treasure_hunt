# Installation

## database configuration

- copy config/database.sample.yml to config/database.yml and configure to your liking
- create a db user `createuser -s -r treasure_hunt`
- now create and seed the database `rake db:setup db:seed`
