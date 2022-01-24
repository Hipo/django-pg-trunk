FROM python:3.10.0 as base

COPY requirements.txt .
COPY requirements_dev.txt .
RUN pip install -U pip && pip install -r requirements.txt && pip install -r requirements_dev.txt

WORKDIR /pg_trunk

FROM base as application
