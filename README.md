# Airflow-Docker
An [Apache Airflow](https://airflow.apache.org/) stack for [docker](https://www.docker.com/), orchestrated using [`docker-compose`](https://docs.docker.com/compose/).

Note that this is just a minial Airflow installation (Airflow Core). [Provider packages](https://airflow.apache.org/docs/) and [other extras](https://airflow.apache.org/docs/apache-airflow/stable/extra-packages-ref.html) will need to be installed once the containers are up and running.

## Getting started
1. Set the following (required) environment variables:
    
    * `AIRFLOW_DOCKER_PASSWORD` - this password is used anywhere a password is required: postgres, pgadmin, Airflow webserver, etc...
    * `AIRFLOW_DOCKER_EMAIL` - use as the login email for pgAdmin and email address for Airflow admin user.

1. Start up the containers: `docker-compose up -d`

The Airflow scheduler and webserver each have their own container (define in [airflow-common](./airflow-common.yml])). Using bind mounts, the projects root directory is treated as the `AIRFLOW_HOME` directory and mounted in the containers at `/opt/airflow`.

User packages (`/home/airflow/.local`) also get their own volume - allowing for packages installed in the containers to persist across session (as long as the volume is available).

## Credentials
|Service/app      |Username/email        |Password                 |Web console                              |
|:----------------|----------------------|-------------------------|----------------------------------------:|
|Postgres         |`postgres`            |`AIRFLOW_DOCKER_PASSWORD`|N/A                                      |
|pgAdmin          |`AIRFLOW_DOCKER_EMAIL`|`AIRFLOW_DOCKER_PASSWORD`|[localhost:80](http://localhost:80)      |
|Airflow webserver|`dadmin`              |`AIRFLOW_DOCKER_PASSWORD`|[localhost:8080](http://localhost:8080)  |
|

## Images
The following images are used:
* [PostgreSQL](https://hub.docker.com/_/postgres)
* [Apache Airflow](https://hub.docker.com/r/apache/airflow)
* [pgAdmin](https://hub.docker.com/r/dpage/pgadmin4)
