### Build

    $ docker build -t rails_base --no-cache .
    $ docker tag rails_base chamnapchhorn/rails_base:2.6.1-alpine-prod
    $ docker push chamnapchhorn/rails_base:2.6.1-alpine-prod
