#!/bin/bash

rm -f /var/lib/mongodb/mongod.lock
mongod -f /etc/mongod.conf --quiet &
pritunl start
pritunl set vpn.log_lines 0
