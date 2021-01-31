FROM apache/airflow:latest
WORKDIR /opt/scripts
COPY --chown=airflow:5000 scripts/*.sh ./
RUN chmod +x *.sh
WORKDIR /opt/airflow
RUN pip install -U pip
ARG extras=PLACEHOLDER
RUN pip install -U "apache-airflow[$extras]"
ARG requirements=.requirements.default.txt
COPY $requirements ./$requirements
RUN pip install -U -r $requirements