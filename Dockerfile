FROM ruby:2.7.6-slim

# Install dependencies
RUN apt-get update -qq; \
    apt-get install -y build-essential \
                       sqlite3 libsqlite3-dev \
                       libpq-dev;

# Setup Workdir
RUN mkdir /app
WORKDIR /app

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true

# Cache gems
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install gems
RUN bundle config set without 'development test' && \
    bundle config --delete without && \
    bundle config --delete with && \
    bundle install

COPY . /app

RUN mkdir -p tmp/pids

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 80
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["bundle", "exec", "puma"]