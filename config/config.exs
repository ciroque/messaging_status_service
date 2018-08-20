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

config :messaging_status_service, :calls,
  TWILIO_ACCOUNT_SID: System.get_env("CIROQUE_TWILIO_ACCOUNT_SID") || "${CIROQUE_TWILIO_ACCOUNT_SID}",
  TWILIO_SID: System.get_env("CIROQUE_TWILIO_SID") || "${CIROQUE_TWILIO_SID}",
  TWILIO_SECRET: System.get_env("CIROQUE_TWILIO_SECRET") || "${CIROQUE_TWILIO_SECRET}"

config :messaging_status_service, :calls,
  call_completed_handler: MessagingStatusService.Calls.EctoBackedCallCompletedHandler,
  sms_completed_handler: MessagingStatusService.Sms.EctoBackedSmsCompletedHandler,
  log_source: MessagingStatusService.TwilioLogSource,
  data_source_sink: MessagingStatusService.Calls.CompositeDataSourceSink,
  composite_data_source_sink_targets: [
    MessagingStatusService.Calls.CallLogs
  ],
  error_sink: Logger,
  http_client: HTTPoison,
  requeue_delay: 5_000,
  sms_response_redirect: "https://handler.twilio.com/twiml/EHbf859cf0977b0c6ec2c9f465f065714b"

import_config "#{Mix.env}.exs"
