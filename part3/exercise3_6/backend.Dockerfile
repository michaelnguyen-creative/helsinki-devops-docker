# Use the official Golang image as the base image
FROM golang:1.20-alpine AS go-build

# Set the working directory to root
WORKDIR /

# Copy the local package files to the container's workspace
COPY ./example-backend .

# Set an environment variable for the request origin
ENV REQUEST_ORIGIN=http://localhost:4000

# Build the Go application
RUN go build

# Create a new image from the alpine image
FROM alpine:3.18

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy the server binary from the go-build image to the current directory
COPY --from=go-build /server .

# Create a new user called appuser
RUN adduser -D appuser

# Set the user to appuser
USER appuser

# Set the command to run the server
CMD ["./server"]