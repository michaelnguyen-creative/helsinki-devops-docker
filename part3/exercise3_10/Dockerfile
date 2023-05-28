# Containerize ruby-example-project from materials-apps provided in the course

# Use the official Ruby 3.1.0-alpine image as the base image
FROM ruby:3.1.0-alpine

# Set the working directory to /app
WORKDIR /app

# Install necessary packages
RUN apk add --no-cache build-base nodejs npm sqlite-dev tzdata

# Create a new user called appuser
RUN adduser -D appuser

# Copy the Gemfile and Gemfile.lock from the rails-example-project to the working directory
COPY ./rails-example-project/Gemfile* ./

# Install the required gems
RUN gem install bundler:2.3.3 && bundle install

# Copy the rest of the application files to the working directory
COPY --chown=appuser ./rails-example-project .

# Run migrations
RUN rails db:migrate RAILS_ENV=production

# Precompile assets
RUN rake assets:precompile

# Expose port 3000 for HTTP traffic
EXPOSE 3000

# Set the user to appuser
USER appuser

# Start the app in production mode
CMD ["rails", "s", "-e", "production"]