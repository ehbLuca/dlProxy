#!/bin/sh

squid 2> /dev/null

tail -f /var/log/squid/cache.log
