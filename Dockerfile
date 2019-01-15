FROM ruby:2.6.0
MAINTAINER Jonathan Claudius
COPY ./lib /app/lib
COPY ./bin /app/bin
COPY ./data /app/data
COPY ./config/policies/ /app/config/policies
COPY ./Gemfile /app/Gemfile
COPY ./ssh_scan_worker.gemspec /app/ssh_scan_worker.gemspec
COPY ./lib /app/lib
COPY ./bin /app/bin

RUN cd /app && \
    gem install bundler && \
    bundle install