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


# Assignment description
## Main assignment

You are writing a web endpoint for a treasure hunt game. It allows participants to send requests to an endpoint, containing their current position(latitude and longitude in decimal representation) and email. Response contains a distance to the treasure expressed in meters. When players are in a 5 meter radius from the treasure an e-mail message with congratulations and exact position of the treasure is sent on the provided e-mail address.
Congratulations email is sent only once. 

Treasure location: 50.051227 N, 19.945704 E

Request format: 

`/treasure_hunt.json?current_location[]=:latitude&current_location[]=:longitude&email=:email`

Example request:

`POST /treasure_hunt.json?current_location[]=0&current_location[]=0&email=test@example.com`

Example response:

```
Successful response
            { “status”: “ok”, “distance”: 10  }
Error response
            { “status”: “error”, “distance”: -1, “error”: “error description” } 
```

Email Content: “Hey, you’ve found a treasure, congratulations!
You are [:nth] treasure hunter who has found the treasure.” Replace [:nth] with the actual number of treasure hunters who successfully found a treasure before + 1.”

## Bonus Points
You don’t have to implement all, you can choose points you want to include in the project.

1. include unit and functional tests
2. add token - based authentication for API requests
3. Allow 20 requests per hour for a given email.
4. (optional) include deployment script for a platform of choice.
5. Add an analytics endpoint, that returns information about location of all the requests that happened in the time window provided in parameters. If a radius parameter is given, response should include only requests that is no further away than :radius meters from the treasure location.

Request format
`GET /analytics.json?start_time[]=:start_time&end_time=:end_time&radius=:radius`

Sample response:
`{ "status": "ok", "requests": [ { "email": "test@test.com", "current_location": [1.1, 2.2] }, { "email": "test2@test.com", "current_location": [0.0, 0.0] } ] }`

6. You’re preparing API for world treasure hunt championships. You are given the task of preparing a streaming endpoint that would allow treasure hunt enthusiasts to follow the latest events. Add a new endpoint that accomplishes that task. It does not need neither throttling nor authentication. Prepare sample client code using that endpoint.

