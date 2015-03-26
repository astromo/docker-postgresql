#!/bin/bash

# Set our variables
: ${DB_SUPER_USER:=postgres}
: ${DB_USER:=astromo}
: ${DB_PASSWORD:=astromo}
: ${DB_NAME:=astromo}
: ${DB_ENCODING:=UTF-8}
: ${DB_PG_DUMP_FILE:=/tmp/astromo.sql}

# Enable the crypto extension
gosu postgres postgres --single -jE <<-EOSQL
  CREATE EXTENSION pgcrypto;
EOSQL

# Create our user
gosu postgres postgres --single -jE <<-EOSQL
  CREATE USER "$DB_USER" WITH PASSWORD '$DB_PASSWORD';
EOSQL

# Create our database and set out new user as the owner
gosu postgres postgres --single -jE <<-EOSQL
  CREATE DATABASE "$DB_NAME" WITH OWNER="$DB_USER" TEMPLATE=template0 ENCODING='$DB_ENCODING';
EOSQL

# Start the server (temporarily)
gosu postgres pg_ctl start -w

# Import our SQL seed
psql -f ${DB_PG_DUMP_FILE} -d ${DB_NAME} -U ${DB_SUPER_USER}

# Stop the server
# The main script in the Docker will reboot it again, don't worry
gosu postgres pg_ctl stop -w