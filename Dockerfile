FROM postgres:9.4

# Add our init script and database seed to the correct folders
ADD seed/init-database.sh /docker-entrypoint-initdb.d/
ADD seed/astromo.sql /tmp/astromo.sql