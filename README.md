# DECIDe Federating Catalog

This app provides a Federated Catalog for a data space.  The members of a data space each publish meta data on the catalogues and data sets they have.  This app consumes that meta data and publishes a combined overview that users can search for data sets they are interested in.

This app relies on LDES to retrieve data from data space members.  Furthermore, data space members should use DCAT to describe their data set meta data.  The obtained meta data is combined and republished using LDES.  In addition a frontend is available oriented at human users as well as a SPARQL endpoint.

![Overview of the app](./doc/app-overview.jpg)


## What's included

This repository contains multiple docker-compose files

- _docker-compose.yml_ This provides you with the backend components.
- _docker-compose.dev.yml_ Provides changes for a good frontend development setup.
  - publishes the backend services on port 80 directly.
  - publishes the database instance on port 8890 so you can easily query this


## Running and maintaining

General information on running and maintaining an installation.


### Getting started

1. Clone the repository and go into the directory
2. To ease all typing for `docker compose` commands create a compose override file in the root of the project

```bash
touch docker-compose.override.yml
```

3. Create an `.env` file so we can define the compose files and other environment variables

```bash
touch .env
```

4. Set the `COMPOSE_FILE` in the `.env`

```bash
COMPOSE_FILE=docker-compose.yml:docker-compose.dev.yml:docker-compose.override.yml
```


### Running the stack
This should be your go-to way of starting the stack.

```bash
docker compose up -d # run without -d flag when you don't want to run it in the background
```


## LDES

This app uses the [ldes-client](https://github.com/lblod/ldes-client) service to obtain its data from multiple LDES feeds.  These feeds are configured in the [configuration file](./config/ldes-client/config.ts) for the LDES client service.  After editing this configuration `docker compose restart ldes-client` for the changes to take effect.  If you enabled development mode for the `ldes-client` service, any changes will be picked up automatically by the live reload functionality.

It is possible that the exact URL of a consumed feed depends on which environment an app instance is deployed in.  For example, a development instance likely consumes data from other development apps, whereas a production instance consumes from other production apps.  To support this, one can define the environment variables for a feed's `LDES_BASE` and `FIRST_PAGE`.  These environment variables can be set as usual in the configuration for docker compose.  In the `config.ts` file, `process.env.SOME_ENV_VAR` can be used to get the value of the `SOME_ENV_VAR`.  The configuration for the `decide-public` endpoint illustrates this approach.


The produced LDES feed, by default, uses as base URL `https://catalog.decide.lblod.info/ldes/`.  To change this to another URL, set the following two environment variables to that value:

- `LDES_BASE` for the `ldes-delta-pusher` service
- `BASE_URL` for the `ldes-serve-feed` service
