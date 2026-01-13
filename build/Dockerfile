FROM openjdk:25-ea-21-jdk-slim
WORKDIR /app

RUN apt-get update && apt-get install -y wget unzip qemu-user-static binfmt-support && rm -rf /var/lib/apt/lists/*

# Copy and set executable permission for entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the default port (UDP)
EXPOSE 5520/udp

# Set entrypoint and CMD
ENTRYPOINT ["/entrypoint.sh"]