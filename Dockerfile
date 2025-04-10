# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.8
FROM ruby:$RUBY_VERSION-slim AS base

# Install essential dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    nodejs \
    libpq-dev \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Set production environment
ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test

# Copy only necessary files for bundle install
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs=4 --retry=3 && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Create a non-root user
RUN useradd -m appuser && \
    chown -R appuser /app
USER appuser

# Configure the entry point
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]