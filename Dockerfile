FROM ciroque/phoenix-apps-build AS BUILD_STEP

ARG mix_env

ENV MIX_ENV=$mix_env
RUN mkdir -p /opt/app

RUN echo [[[ $mix_env ]]]

WORKDIR /opt/apps/messaging_status_service

RUN \
  mkdir -p  \
    apps/messaging_status_service/config \
    apps/messaging_status_service_web/config \
    config \
    rel \
    deps

# Cache elixir deps
COPY mix.exs mix.lock ./
COPY config ./config
COPY apps/messaging_status_service/mix.exs ./apps/messaging_status_service/
COPY apps/messaging_status_service/config ./apps/messaging_status_service/config
COPY apps/messaging_status_service_web/mix.exs ./apps/messaging_status_service_web/
COPY apps/messaging_status_service_web/config ./apps/messaging_status_service_web/config
COPY deps ./deps
COPY rel/config.exs rel/

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix do deps.get --only prod, deps.compile \
  && mix deps.clean --build ecto

RUN pwd && du -hs .

COPY . .

WORKDIR /opt/apps/messaging_status_service/apps/messaging_status_service_web/assets
RUN ./node_modules/brunch/bin/brunch b -p

WORKDIR /opt/apps/messaging_status_service
RUN mix phx.digest

RUN echo [[[ $mix_env ]]]
RUN MIX_ENV=$mix_env mix release --env=$mix_env

RUN find . -name *.tar.gz

## ####################################
## RELEASE!
FROM elixir:1.5.1-slim

ARG mix_env
RUN echo [[[ $mix_env ]]]

EXPOSE 4000
ENV PORT=4000 \
  MIX_ENV=$mix_env \
  REPLACE_OS_VARS=true \
  SHELL=/bin/sh

ARG SOURCE_COMMIT=0
ENV COMMIT_HASH $SOURCE_COMMIT 
ENV TARBALL=messaging_status_service.tar.gz

WORKDIR /opt/apps/messaging_status_service

COPY --from=BUILD_STEP /opt/apps/messaging_status_service/_build/$mix_env/rel/messaging_status_service/releases/0.1.0/$TARBALL ./

RUN tar -xzf $TARBALL
RUN rm $TARBALL

RUN pwd && ls -lr

ENTRYPOINT ["/opt/apps/messaging_status_service/bin/messaging_status_service"]
CMD ["foreground"]
