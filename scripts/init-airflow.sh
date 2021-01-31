#!/usr/bin/env bash
set -e
source scripts/log4bash.sh

init_airflow() {
  log "Initializing database"
  airflow db init
  log "Creating default user"
  airflow users create -f Docker -l Admin -r Admin -u dadmin -e "$AIRFLOW_DOCKER_EMAIL" -p "$AIRFLOW_DOCKER_PASSWORD"
}

log "Checking if Airflow has been initialized..."
if [ -f "$AIRFLOW_HOME/airflow.cfg" ]; then
  log "Airflow initialized..."
  if [ "$SERVICE" == "webserver" ]; then
    log "Starting webserver"
    airflow webserver
  else
    log "Starting scheduler"
    airflow scheduler
  fi
else
  log "Airflow not initialized. Initializing it for the first time"
  init_airflow
fi
