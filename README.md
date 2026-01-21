> [!WARNING]  
> This does not work since hytale updated .zip name file when downloading server files. You will need to unzip the file manually and restart the server and it will continue working. I will not update this repo since I know made a custom pterodactyl full dockerized server for hosting this type of game server through ptero eggs.

# Hytale Server in Docker

This repository contains a Docker configuration to run a Hytale server. It uses Docker Compose to manage the server container.

## docker-compose.yml File

Here is the content of the `docker-compose.yml` file used to start the server:

```yaml
services:
  hytale-server:
    image: ghcr.io/samueleoraziodurante/hytale-server:latest
    container_name: hytale-server
    ports:
      - "5520:5520/udp"
    volumes:
      - ./data:/app
    restart: unless-stopped
    environment:
      - MIN_RAM=2g # default: 2g
      - MAX_RAM=4g # default: 4g
      - GARBAGE_COLLECTOR_TYPE=G1GC # default: G1GC
      - ENABLE_AOT_CACHE=true # default: true
      # - EXTRA_JVM_OPTS= # Optional
```

## Repository Description

This repository provides a simple way to run a Hytale server using Docker. The container automatically downloads the necessary game files and starts the server. It is designed to be easy to use, with customizable configurations via environment variables.

## First Startup and OAuth Authorization

On the first server startup, the container will download the game files. During this process, you need to authorize the server via OAuth to complete the download.

- Start the container with `docker-compose up`.
- Open the container logs using `docker-compose logs -f hytale-server`.
- In the logs, you will find an OAuth authorization link. Click the link and follow the instructions to authorize the server.
- Once authorized, an authentication file will be created in the `data` directory. This file will be used for all subsequent server starts or file downloads.

After completing the authorization, the container will continue downloading the game files and automatically start the server.

## Hytale Server Error: “Server session token not available – cannot request auth grant”

If you need to authenticate the server after it has already started, you can run a temporary server instance for authentication using the following command:

```
docker-compose exec hytale-server java -jar /app/Server/HytaleServer.jar ----assets /app/Assets.zip
```

Follow these steps:

1. Start the server.
2. Run `/auth login device`.
3. Authorize in the browser.
4. Run `/auth persistence Encrypted`.
5. Restart safely.

To close the temporary server, press CTRL + C, then run `docker-compose up -d` to restart the server.

## Environment Variables

The following environment variables can be configured in the `docker-compose.yml` file to customize the server's behavior:

- `MIN_RAM`: Minimum RAM allocated to the JVM (default: 2g). Example: `1g`, `4g`.
- `MAX_RAM`: Maximum RAM allocated to the JVM (default: 4g). Example: `2g`, `8g`.
- `GARBAGE_COLLECTOR_TYPE`: JVM garbage collector type (default: G1GC). Options: `G1GC`, `ParallelGC`, `SerialGC`, etc.
- `ENABLE_AOT_CACHE`: Enables AOT cache for better performance (default: true). Options: `true` or `false`.
- `EXTRA_JVM_OPTS`: Additional JVM options (optional). Example: `-XX:+UseStringDeduplication` or other custom options.

Modify these variables in the `docker-compose.yml` file according to your needs before starting the container.
