# Astromo's PostgreSQL Docker Container
PostgreSQL Docker container

## Build the container
Build our image using Docker
`docker build -t astromo/postgresql .`

## Running the container
Run the container using
`docker run --name astromo-postgresql -e POSTGRES_PASSWORD=root -p 5432:5432 -d astromo/postgresql`
