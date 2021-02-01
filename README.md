# Airflow-Docker

An [Apache Airflow](https://airflow.apache.org/) stack for [docker](https://www.docker.com/), orchestrated using
[`docker-compose`](https://docs.docker.com/compose/). pgAdmin is included to easily view and manage Airflow's meta
database.

**NOTE:** I put this together to learn docker. As such, I wouldn't recommend using it in production as is.

## Getting started

Set the following environment variables:

* `AIRFLOW_DOCKER_PASSWORD` - use anywhere a password is required: postgres, pgadmin, Airflow webserver, etc...
* `AIRFLOW_DOCKER_EMAIL` - use as the email for the default pgaAdmin and Airflow admin user.

### Airflow Core

To start the containers with just a minial installation (Airflow Core), run: `docker-compose up -d`.

### Installing extra packages

To install [extra Airflow packages](https://airflow.apache.org/docs/apache-airflow/stable/extra-packages-ref.html),
you'll need to first build the image, specifying the `extras` build arg. [Additional build args](#build-args) can be
found below.

1. `docker-compose build --build-arg extras=ssh,microsoft.mssql,http`
1. `docker-compose up -d`

The Airflow scheduler and webserver each have their own container (define in [airflow-common](./airflow-common.yml)).
The `airflow` directory is mounted in the containers as `AIRFLOW_HOME` at `/opt/airflow`.

## Build Args

These build args can be specified when building images for the Airflow containers.

|Arg           |Purpose               |Example                           |
|:-------------|----------------------|---------------------------------:|
|`extras`      |specifies [extra Airflow packages](https://airflow.apache.org/docs/apache-airflow/stable/extra-packages-ref.html) to install|`extras=ssh,microsoft.mssql,http` |
|`requirements`|path to a `pip` requirements file use to install all other Python packages|`requirements=../requirements.txt`|

## Credentials

|Service/app      |Username/email        |Password                 |Web console                              |
|:----------------|----------------------|-------------------------|----------------------------------------:|
|Postgres         |`postgres`            |`AIRFLOW_DOCKER_PASSWORD`|N/A                                      |
|pgAdmin          |`AIRFLOW_DOCKER_EMAIL`|`AIRFLOW_DOCKER_PASSWORD`|[localhost:80](http://localhost:80)      |
|Airflow webserver|`dadmin`              |`AIRFLOW_DOCKER_PASSWORD`|[localhost:8080](http://localhost:8080)  |

## Images

The following images are used:

* [PostgreSQL](https://hub.docker.com/_/postgres)
* [Apache Airflow](https://hub.docker.com/r/apache/airflow)
* [pgAdmin](https://hub.docker.com/r/dpage/pgadmin4)
