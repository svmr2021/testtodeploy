FROM python:3.9-alpine

ENV PATH='/scripts:${PATH}/'

WORKDIR /app
ADD . /app

RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install psycopg2-binary
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
RUN apk del .tmp

RUN mkdir /app
COPY . /app
COPY ./scripts /scripts

RUN  chmod +x /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/

RUN adduser -D user
RUN chown -R user:user /vol
RUN chmod -R 755 /vol/web
USER user

CMD ["entrypoint.sh"]


