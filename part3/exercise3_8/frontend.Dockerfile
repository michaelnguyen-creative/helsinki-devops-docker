# Use the official Node.js 16 Alpine image as the base image
FROM node:16-alpine AS node-build

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY ./example-frontend/package*.json .

# Install production dependencies
RUN npm ci --only=production

# Copy the rest of the application files to the working directory and set appuser as the owner
COPY ./example-frontend .

# Set the environment variable REACT_APP_BACKEND_URL to http://localhost:8080
ENV REACT_APP_BACKEND_URL=http://localhost:8080

# Build the application
RUN npm run build

# Use the official Alpine image as the base image
FROM alpine:3.15

WORKDIR /usr/src/app

# Install the serve package
RUN apk add --no-cache nodejs npm && \
    npm install -g serve

# Copy the built application from the node-build stage to the Nginx image
COPY --from=node-build /usr/src/app/build .

CMD ["serve", "-sl", "4000", "."]