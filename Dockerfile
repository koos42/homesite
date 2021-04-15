FROM ruby:1.9.3

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ENV SOURCE /src
WORKDIR $SOURCE
ADD . $SOURCE


