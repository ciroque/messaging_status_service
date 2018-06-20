FROM ciroque/phoenix-apps-build AS BUILD_STEP

ENV MIX_ENV=prod

RUN mkdir -p /opt/app

WORKDIR /opt/apps/messaging_status_service

RUN \
  mkdir -p  \
    config \
    rel \
    deps

COPY mix.exs mix.lock ./
COPY config ./config
COPY deps ./deps
COPY rel/config.exs rel/

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix do deps.get --only prod, deps.compile \
  && mix deps.clean --build ecto

COPY . .

RUN mix phx.digest

RUN MIX_ENV=$MIX_ENV mix release --env=$MIX_ENV

## ####################################
## RELEASE!
FROM elixir:1.5.1-slim

ENV MIX_ENV=prod

EXPOSE 4000
ENV PORT=4000 \
  MIX_ENV=$MIX_ENV \
  REPLACE_OS_VARS=true \
  SHELL=/bin/sh

ARG SOURCE_COMMIT=0
ENV COMMIT_HASH $SOURCE_COMMIT 
ENV TARBALL=messaging_status_service.tar.gz

WORKDIR /opt/apps/messaging_status_service

COPY --from=BUILD_STEP /opt/apps/messaging_status_service/_build/$MIX_ENV/rel/messaging_status_service/releases/0.0.1/$TARBALL ./

RUN tar -xzf $TARBALL
RUN rm $TARBALL

ENTRYPOINT ["/opt/messaging_status_service/bin/messaging_status_service"]
CMD ["foreground"]
