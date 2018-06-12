defmodule MessagingStatusService.CallStatusHandling.CompositeDataSourceSink do
  @behaviour MessagingStatusService.CallStatusHandling.DataSourceSinkBehaviour

  require Logger

  @data_source_sinks [
    MessagingStatusService.CallLogs
  ]

  def store_call_log(call_log) do
    Logger.debug("#{__MODULE__}::store_call_log call_log(#{inspect(call_log)})")

    results = @data_source_sinks |> Enum.map(fn data_source_sink ->
      data_source_sink.store_call_log(call_log)
    end)

    Logger.debug("#{__MODULE__}::store_call_log results: #{inspect(results)}")

    :ok
  end
end
