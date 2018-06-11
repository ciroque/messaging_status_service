use Mix.Config

config :messaging_status_service,
  ecto_repos: [MessagingStatusService.Repo]

config :messaging_status_service, MessagingStatusServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wrv4V5gSaZMJevcuRgtiaN6dsA5ezxTzUAiaXEBwx/sET4KI70N8Nf/+Ms7zTXD8",
  render_errors: [view: MessagingStatusServiceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MessagingStatusService.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :messaging_status_service, :call_status_handling,
  TWILIO_ACCOUNT_SID: System.get_env("CIROQUE_TWILIO_ACCOUNT_SID") || "${CIROQUE_TWILIO_ACCOUNT_SID}",
  TWILIO_SID: System.get_env("CIROQUE_TWILIO_SID") || "${CIROQUE_TWILIO_SID}",
  TWILIO_SECRET: System.get_env("CIROQUE_TWILIO_SECRET") || "${CIROQUE_TWILIO_SECRET}"

config :messaging_status_service, :call_status_handling,
  requeue_delay: 5_000,
  call_status_handler: MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker,
  call_log_source: MessagingStatusService.CallStatusHandling.TwilioCallLogSource,
  data_source_sink: MessagingStatusService.CallStatusHandling.CompositeDataSourceSink

import_config "#{Mix.env}.exs"
