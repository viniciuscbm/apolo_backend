FROM ruby:2.7.2

LABEL maintainer="Vinicius Camboim"

# Create the workdir
RUN mkdir /app

# Set our path as the main directory
WORKDIR /app

# Optimizing Dockerfile caching for Bundler
COPY Gemfile Gemfile.lock ./

# Install gems on containers
RUN bundle install

# Copy our code into the container
COPY . .

# Run the application
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0
