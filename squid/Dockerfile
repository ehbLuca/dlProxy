FROM alpine

ARG dev

RUN apk update

# Dev dependencies
RUN [ -z "$dev" ] && : || apk add curl iproute2 vis

RUN apk add squid

COPY ./squid.conf /etc/squid/squid.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN squid -z --foreground

CMD ["/entrypoint.sh"]

EXPOSE 3128
