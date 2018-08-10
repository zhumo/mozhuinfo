FROM ruby:2.4.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client nodejs \
  && apt-get -q clean \
  # Remove artifacts of apt-get to reduce final image size
  && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/mozhuinfo

# Separate gemfile copy from all-files copy so that a Docker layer gets created for gems.
# This ensures that when app files are changed, we don't have to reinstall gems.
COPY Gemfile* ./
RUN bundle install
COPY . .

# TODO: Consider storing bundled dependencies locally so that each time you update gems,
# you don't have to re-install the whole list of dependencies, as per: http://bradgessler.com/articles/docker-bundler/

EXPOSE 3000
