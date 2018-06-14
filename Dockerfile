FROM ciroque/phoenix-apps-build AS BUILD_STEP

ARG mix_env

ENV MIX_ENV=prod
RUN mkdir -p /opt/app

RUN echo [[[ $mix_env ]]]

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

RUN pwd && du -hs .

COPY . .

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

COPY --from=BUILD_STEP /opt/apps/messaging_status_service/_build/$mix_env/rel/messaging_status_service/releases/0.0.1/$TARBALL ./

RUN tar -xzf $TARBALL
RUN rm $TARBALL

RUN pwd && ls -lr

ENTRYPOINT ["/opt/messaging_status_service/bin/messaging_status_service"]
CMD ["foreground"]
