FROM python:3.5.2-alpine
LABEL maintainer="Ewerton Santos <ewertonpinheiros@gmail.com>"
EXPOSE 8000
RUN apk update && apk upgrade && apk add --update --no-cache  \
&& rm -rf /var/lib/apt/lists/*

COPY ./django-realworld-example-app /django-app
WORKDIR /django-app
RUN pip install -r requirements.txt
CMD [ "python","manage.py","runserver","0.0.0.0:8000" ]