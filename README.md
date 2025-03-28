# Vapor auth template

This is a simple auth template for vapor using JWT. It is a starting point to build for projects that require a simple auth solution.

## Setup

Additional setup for this project is creating the appropiate `.env.development` files with the following keys

```
POSTGRES_USERNAME=
POSTGRES_PASSWORD=
POSTGRES_HOSTNAME=
POSTGRES_PORT=
POSTGRES_DATABASE=

JWT_KEY=
```

In order for unit testing to work there must be a `.env.testing` file.