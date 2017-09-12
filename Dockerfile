FROM ruby:2.3.4-jessie

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY $SHIPPABLE_BUILD_DIR/Gemfile /usr/src/app/
ONBUILD COPY $SHIPPABLE_BUILD_DIR/Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY $SHIPPABLE_BUILD_DIR/. /usr/src/app

EXPOSE 8080

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
