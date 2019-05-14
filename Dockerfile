FROM ruby:2.6.1-alpine

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash git" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev pcre-dev libffi-dev tzdata yaml-dev imagemagick" \
    DB_PACKAGES="postgresql-dev postgresql-client" \
    RUBY_PACKAGES="ruby-json yaml nodejs yarn ruby-nokogiri"

# Update and install base packages
RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $DB_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*
