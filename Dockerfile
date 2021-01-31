FROM apache/airflow:latest
WORKDIR /opt/scripts
COPY --chown=airflow:5000 scripts/*.sh ./
RUN chmod +x *.sh
RUN pip install -U pip
ARG extras=PLACEHOLDER
RUN pip install -U "apache-airflow[$extras]"