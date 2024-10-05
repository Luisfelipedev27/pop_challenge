Developer: Luis Felipe Taveira Barbosa

### Installation

Follow the steps below

```sh
$ docker-compose build

$ docker-compose run web bundle exec rails db:create

$ docker-compose run web bundle exec rails db:migrate

$ docker-compose up
```

### Running Tests

Use the following commands to run the automated tests.

```sh
$ docker-compose run web bundle exec rspec
```

### Enpoints

```sh
# POST/ ENDPOINT TO IMPORT RESTAURANTS
http://localhost:3000/api/v1/imports #body: { file: restaurant_data.json }
 # Use postman to upload a file -> restaurant_data.json

# GET/ ENDPOINT TO LIST RESTAURANTS
http://localhost:3000/api/v1/restaurants

# GET/ ENDPOINT TO LIST A RESTAURANT /:Id
http://localhost:3000/api/v1/restaurants/1

# GET/ ENDPOINT TO LIST MENUS
http://localhost:3000/api/v1/menus

# GET/ ENDPOINT TO LIST A MENU /:Id
http://localhost:3000/api/v1/menus/1
```
