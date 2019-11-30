FROM python:3.7-slim-buster

LABEL maintainer="Marc Laughton (bashhack) - <info@marclaughton.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Python, don't write bytecode!
ENV PYTHONDONTWRITEBYTECODE 1

# -- Install Pipenv:
RUN apt update && apt install python3.7-dev libffi-dev gcc curl -y
RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python3.7

# Backwards compatility.
RUN rm -fr /usr/bin/python3 && ln /usr/bin/python3.7 /usr/bin/python3

RUN pip3 install pipenv

# -- Adding Pipfiles
COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock

# -- Install dependencies:
RUN pipenv install --deploy --system

# -- Execute application
COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY gunicorn_conf.py /gunicorn_conf.py

COPY start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY app /app
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

# Executing `start.sh` will:
# - check for an `/app/prestart.sh` script (e.g. for migrations),
# - start Gunicorn with Uvicorn
CMD ["/start.sh"]
