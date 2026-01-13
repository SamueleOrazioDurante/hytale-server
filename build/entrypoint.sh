#!/bin/bash

SERVER_INSTALLER_URL="https://downloader.hytale.com/hytale-downloader.zip"
SERVER_INSTALLER_ZIP="hytale-downloader.zip"
SERVER_INSTALLER="hytale-downloader-linux-amd64"
SERVER_ZIP="2026.01.13-dcad8778f.zip"
SERVER_EXECUTABLE="Server/HytaleServer.jar"
ASSETS_ZIP="Assets.zip"

# Generate JAVA_OPTS from environment variables
JAVA_OPTS="-Xms${MIN_RAM:-2g} -Xmx${MAX_RAM:-4g} -XX:+Use${GARBAGE_COLLECTOR_TYPE:-G1GC}"
if [ "${ENABLE_AOT_CACHE:-true}" = "true" ]; then
    JAVA_OPTS="$JAVA_OPTS -XX:AOTCache=HytaleServer.aot"
fi
if [ -n "${EXTRA_JVM_OPTS}" ]; then
    JAVA_OPTS="$JAVA_OPTS $EXTRA_JVM_OPTS"
fi

if [ ! -f "$SERVER_EXECUTABLE" ]; then
    if [ ! -f "$SERVER_ZIP" ] || [ ! -f "$ASSETS_ZIP" ]; then
        if [ ! -f "$SERVER_INSTALLER" ]; then
            echo "Downloading server files..."
            wget "$SERVER_INSTALLER_URL" && unzip "$SERVER_INSTALLER_ZIP"  && rm "$SERVER_INSTALLER_ZIP"  hytale-downloader-windows-amd64.exe QUICKSTART.md
        fi
        echo "Running downloader..."
        chmod +x "$SERVER_INSTALLER"
        ./"$SERVER_INSTALLER"
        rm "$SERVER_INSTALLER"
        echo "Downloader finished."
    fi
    unzip "$SERVER_ZIP"
    rm "$SERVER_ZIP"
fi
exec java $JAVA_OPTS -jar $SERVER_EXECUTABLE --assets $ASSETS_ZIP