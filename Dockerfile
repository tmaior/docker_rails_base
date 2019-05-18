FROM ruby:2.6.1

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' 10 > /etc/apt/sources.list.d/pgdg.list \
  && apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    apt-utils \
    less \
    vim \
    libpq-dev \
    postgresql-client-10 && \
    rm -rf /var/lib/apt/lists/*

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN groupadd -r deployer && useradd -m -r -g deployer deployer

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
