FROM ruby:2.6.1-alpine

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash git" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev pcre-dev libffi-dev tzdata yaml-dev imagemagick" \
    DB_PACKAGES="postgresql-dev postgresql-client" \
    RUBY_PACKAGES="ruby-json yaml nodejs yarn ruby-nokogiri"

# Update and install base packages
RUN apk update && \
    apk upgrade && \
    apk add --update \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $DB_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN addgroup -S deployer -g 1000 && adduser -S -g '' -u 1000 -G deployer deployer

ENV APP_PATH=/app \
    PUBLIC_PATH=/app/public \
    TEMP_PATH=/app/tmp \
    NODE_MODULES_PATH=/app/node_modules \
    BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Manually create required volumes, https://github.com/docker/compose/issues/3270
RUN mkdir -p $APP_PATH \
  && mkdir -p $BUNDLE_PATH \
  && mkdir -p $TEMP_PATH \
  && mkdir -p $NODE_MODULES_PATH \
  && mkdir -p $PUBLIC_PATH \
  && chown -R deployer:deployer $BUNDLE_PATH \
  && chown -R deployer:deployer $TEMP_PATH \
  && chown -R deployer:deployer $NODE_MODULES_PATH \
  && chown -R deployer:deployer $PUBLIC_PATH
