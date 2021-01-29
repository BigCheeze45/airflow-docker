#!/usr/bin/env bash
set -e
source scripts/log4bash.sh

init_webserver() {
    if [ $? -eq 0 ]; then
        log "Database is up..waiting to accept connections"
        sleep 25
        log "Checking if database has been initialized"
        if [ -f ".AIRFLOW_INIT" ]; then
            log "Airflow database already initiazlied"
        else
            log "Initializing database"
            airflow db init
            log "Creating default user"
            airflow users create -f Docker -l Admin -r Admin -u dadmin -e $AIRFLOW_DOCKER_EMAIL \
            -p $AIRFLOW_DOCKER_PASSWORD
            touch ".AIRFLOW_INIT"
        fi

        log "Starting webserver"
        airflow webserver
    else
        log_error "Database unreachable...Is the metadb container running?"
        return 1
    fi
}

init_scheduler() {
    if [ $? -eq 0 ]; then
        log "Webserver is running...starting scheduler"
        airflow scheduler
    else
        log_error "Webserver doesn't apper to be running. Is the database up?"
        return 1
    fi
}

log "Determing Airflow service..."
if [ "$SERVICE" == "webserver" ]; then
    log "Initalizing Airflow webserver"
    init_webserver
    exit $?
else
    log "Initalizing Airflow scheduler"
    init_scheduler
    exit $?
fi
