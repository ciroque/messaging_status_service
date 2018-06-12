use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :messaging_status_service, MessagingStatusServiceWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :messaging_status_service, :call_status_handling,
  call_status_handler: MessagingStatusService.CallStatusHandling.CallStatusHandlerMock,
  call_log_source: MessagingStatusService.CallStatusHandling.CallLogSourceMock,
  data_source_sink: MessagingStatusService.CallStatusHandling.DataSourceSinkMock,
  error_sink: MessagingStatusService.CallStatusHandling.ErrorSinkMock,
  http_client: MessagingStatusService.CallStatusHandling.HttpClientMock,
  requeue_delay: 500

# Configure your database
config :messaging_status_service, MessagingStatusService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "messaging_status_service_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
