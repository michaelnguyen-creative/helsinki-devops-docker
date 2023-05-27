# Use the official Golang image as the base image
FROM golang:1.20-alpine

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Create a new user called appuser
RUN adduser -D appuser

# Copy the local package files to the container's workspace
COPY --chown=appuser ./example-backend .

# Set an environment variable for the request origin
ENV REQUEST_ORIGIN=http://localhost:4000

# Build the Go application
RUN go build

# Set the user to appuser
USER appuser

# Set the command to run the server
CMD ["./server"]