# This Dockerfile is used to build an image for a Docker CLI application.

# It uses the official Docker image version 24.0-cli as the base image.
FROM docker:24.0-cli

# The working directory is set to /usr/src/app.
WORKDIR /usr/src/app

# The builder.sh script is copied to the working directory with executable permission.
COPY --chmod=+x /builder.sh .

# The entrypoint is set to run the builder.sh script when the container starts.
ENTRYPOINT [ "sh", "/usr/src/app/builder.sh" ]