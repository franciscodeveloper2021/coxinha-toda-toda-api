FROM ruby:latest as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /coxinha-toda-toda-api

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

COPY . .

ENV RAILS_ENV=development

ENTRYPOINT ["/coxinha-toda-toda-api/bin/docker-entrypoint"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
