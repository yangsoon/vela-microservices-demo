# vela-microservices-demo
use vela to deploy microservices


| Service                                              | workload      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](./src/frontend)                           | ms            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](./src/cartservice)                     | ms            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](./src/productcatalogservice) | ms            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](./src/currencyservice)             | ms            | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](./src/paymentservice)               | ms            | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](./src/shippingservice)             | ms            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](./src/emailservice)                   | ms            | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](./src/checkoutservice)             | ms            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](./src/recommendationservice) | ms            | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](./src/adservice)                         | ms            | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](./src/loadgenerator)                 | worker        | Continuously sends requests imitating realistic user shopping flows to the frontend.                                              |
| frontend-external as trait for frontend              | loadbalancer  |                                                                                                                                   |
| redis-cart                                           | ms+ts(volum)  |                                                                                                                                   |