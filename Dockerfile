FROM chamnapchhorn/rails_base:2.6.1-alpine3.9-prod

# Installs latest stable Chromium package.
# https://daniel-starling.com/blog/2018/03/10/capybara-in-alpine-linux/
# https://github.com/Zenika/alpine-chrome
# https://www.dennismclaughlin.tech/build-docker-image-ruby-watir-webdriver-shopify-and-chrome/
RUN apk update && apk upgrade \
    && echo @latest-stable http://nl.alpinelinux.org/alpine/latest-stable/community >> /etc/apk/repositories \
    && echo @latest-stable http://nl.alpinelinux.org/alpine/latest-stable/main >> /etc/apk/repositories \
    && apk add --no-cache \
    chromium-chromedriver@latest-stable \
    chromium@latest-stable \
    harfbuzz@latest-stable \
    nss@latest-stable \
    freetype@latest-stable \
    ttf-freefont@latest-stable \
    wait4ports@latest-stable \
    xorg-server@latest-stable \
    dbus@latest-stable \
    mesa-dri-swrast@latest-stable

# Clean up leftovers to help keep the final image small.
RUN rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

# Set the environment variables for the Chromium browser.
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/
