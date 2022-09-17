FROM --platform=linux/amd64 ruby:3.0.3-alpine
RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      git \
      less \
      libstdc++ \
      libgcrypt-dev \
      netcat-openbsd \
      nodejs \
      pkgconfig \
      postgresql-dev \
      tzdata \
      yarn 

WORKDIR /music-api
COPY Gemfile /music-api/Gemfile
COPY Gemfile.lock /music-api/Gemfile.lock


RUN gem install bundler:2.3.5
RUN bundle install 

COPY . /music-api

CMD ["docker/startup.sh"]

# COPY ./entrypoints/app-entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/app-entrypoint.sh

# ENTRYPOINT ["/usr/bin/app-entrypoint.sh"]