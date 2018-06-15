use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :messaging_status_service, MessagingStatusServiceWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :messaging_status_service, :calls,
  call_completed_handler: MessagingStatusService.Calls.CallCompletedHandlerMock,
  call_log_source: MessagingStatusService.LogSourceMock,
  composite_data_source_sink_targets: [
    MessagingStatusService.Calls.CallLogs
  ],
  data_source_sink: MessagingStatusService.Calls.DataSourceSinkMock,
  error_sink: MessagingStatusService.Calls.ErrorSinkMock,
  http_client: MessagingStatusService.Calls.HttpClientMock,
  requeue_delay: 500

# Configure your database
config :messaging_status_service, MessagingStatusService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "messaging_status_service_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
