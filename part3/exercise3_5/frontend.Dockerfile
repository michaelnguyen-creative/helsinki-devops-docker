# Use the official Node.js 16 Alpine image as the base image
FROM node:16-alpine

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Create a new directory called build
RUN mkdir ./build

# Copy package.json and package-lock.json to the working directory
COPY ./example-frontend/package*.json .

# Install serve globally and install production dependencies
RUN npm i -g serve && npm ci --only=production

# Create a new user called appuser
RUN adduser -D appuser

# Copy the rest of the application files to the working directory and set appuser as the owner
COPY --chown=appuser ./example-frontend .

# Set the environment variable REACT_APP_BACKEND_URL to http://localhost:8080
ENV REACT_APP_BACKEND_URL=http://localhost:8080

# Build the application
RUN npm run build

# Set the user to appuser
USER appuser

# Start the application using serve
CMD ["serve", "-sl", "4000", "build"]