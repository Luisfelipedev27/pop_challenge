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
# Use postman to upload a file -> restaurant_data.json
http://localhost:3000/api/v1/imports #body: { file: restaurant_data.json }
 
# GET/ ENDPOINT TO LIST RESTAURANTS
http://localhost:3000/api/v1/restaurants

# GET/ ENDPOINT TO LIST A RESTAURANT /:Id
http://localhost:3000/api/v1/restaurants/1

# GET/ ENDPOINT TO LIST MENUS
http://localhost:3000/api/v1/menus

# GET/ ENDPOINT TO LIST A MENU /:Id
http://localhost:3000/api/v1/menus/1
```

### API Architecture Overview and Importance
This project implements a well-organized and scalable API architecture using Ruby on Rails. It follows the principles of clean code, separation of concerns, and reusability, which are critical for maintaining and extending APIs efficiently. Here's a breakdown of how this architecture works and why it's beneficial for building APIs.

### Architecture
#### Controller: ImportsController
The ImportsController serves as the interface for handling incoming requests related to restaurant data imports. It implements the following action:
```sh
Create - api/v1/imports
```
- Allows clients to upload a JSON file containing restaurant data, including menus and menu items.
- The create action leverages the Api::V1::RestaurantImporterService, which handles the business logic of parsing and processing the JSON file.

By offloading the import logic to the service class (RestaurantImporterService), the controller stays focused on handling the request and rendering the appropriate response. This separation of concerns enhances maintainability and makes the controller easier to test.


#### Controller: RestaurantsController
The RestaurantsController serves as the interface for handling incoming requests related to restaurants. It implements two essential actions:

```sh
Index - api/v1/restaurants
```
- Fetches all restaurants and their associated menus and menu items.
```sh
Show - api/v1/restaurants/:id
```
- Fetches a specific restaurant by its ID.
- By offloading the business logic to services (```Api::V1::Restaurants::Fetcher``` and ```Api::V1::Restaurants::Renderer```), the controller remains lean and focused solely on request-handling and response rendering. This improves maintainability and makes the code easier to test.

#### Services: Fetcher and Renderer
The business logic is encapsulated within service classes under the ```Api::V1::Restaurants``` namespace. This separation of concerns allows each service to handle a specific responsibility:

This architecture not only promotes reusability but also makes it easier to extend features in the future, such as adding filters to the Fetcher or enhancing error handling in the Renderer.

#### Benefits of This Approach
- Separation of Concerns: By using service objects, business logic is separated from controllers, resulting in more focused and maintainable code.
- Scalability: As the application grows, additional logic can be added to services without cluttering the controllers.
- Testability: Each component (controller, service) can be tested independently, ensuring that logic works as expected.

#### Unit Tests
- Controller Tests: These verify that the controller actions respond with the expected status codes and JSON structures. For example, index should return a list of restaurants, while show should return either a specific restaurant or an error if it doesn’t exist.

- Service Tests: Unit tests for the Fetcher and Renderer classes ensure that they perform their business logic correctly. For Fetcher, tests would verify that the correct data structure is returned. For Renderer, tests would ensure that it handles both success and error cases properly.

#### Integration Tests
- Integration tests can verify the complete flow, from the controller to the database, ensuring that all components interact correctly.

#### Importance of Tests
- Reliability: Automated tests provide confidence that the API works as expected and that future changes won't break existing functionality.
- Maintainability: Well-tested code allows for safer refactoring. As the API evolves, tests ensure that any changes don't introduce regressions.
- Documentation: Tests also serve as living documentation, showing how different parts of the API are expected to behave.
