# django-pg-trunk

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/Hipo/django-pg-trunk/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Hipo/django-pg-trunk/tree/main)
[![PyPI Version](https://img.shields.io/pypi/v/django-pg-trunk.svg)](https://pypi.org/project/django-pg-trunk)
[![Python Versions](https://img.shields.io/pypi/pyversions/django-pg-trunk.svg)](https://pypi.org/project/django-pg-trunk)

A PostgreSQL query profiler for Django that uses `pg_stat_statements` extension.


# Changelog

## v0.1.0
- Project is created.

# Requirements

- Python >= 3.7
- PostgreSQL >= 13
- Django >= 2.2

# Installation

Install using pip:

```
pip install django-pg-trunk
```

Then add `django_pg_trunk` to your `INSTALLED_APPS`.

```python
INSTALLED_APPS = [
    ...
    'django_pg_trunk',
]
```

`django-pg-trunk` will automatically install `pg_stat_statements` extension for PostgreSQL if it doesn't exist, however `pg_stat_statements` should be added to `shared_preload_libraries` in the PostgreSQL config. To do this, you can either run [postgres server](https://www.postgresql.org/docs/current/app-postgres.html) as following as in the test Docker Compose [configuration](docker-compose.yml):

```
postgres -c shared_preload_libraries=pg_stat_statements
```

or you should change `postgresql.conf` file manually and restart the `postgres` server. You can use the [helper script](/scripts/update_pg_config.sh) to change `postgresql.conf`.

# Usage

After installing the package, database queries can be examined under `Pg Trunk > Query Statistics` in Django admin.

<img width="1536" alt="Screen Shot 2022-01-23 at 14 08 23" src="https://user-images.githubusercontent.com/24718583/150675600-de240881-f0f5-4c3f-a1cc-c6034757afc9.png">

Change view have more detailed statistics. All of the columns of `pg_stat_statements` can be found [here](https://www.postgresql.org/docs/13/pgstatstatements.html).

<img width="1536" alt="Screen Shot 2022-01-23 at 14 09 01" src="https://user-images.githubusercontent.com/24718583/150675584-a811952f-6d44-44d6-ae23-050ef94ca7fb.png">

A possible usecase of `QueryStatistic` model can be running a cron job that checks if there is a query that takes more time than a specific thershold, and send related alerts (emails, Slack notifications, etc.).

# Contribution

### As a first step, please open an issue about the feature/bug.

- Development environment can be created using `source scripts/run_development.sh`.
- Tests can be run using `pytest` command. Tests for different environments will be run on CircleCI.
- Changes on Django Admin can be tested using `python manage.py runserver 0:8000` in development Docker container and navigating to http://127.0.0.1/admin.
