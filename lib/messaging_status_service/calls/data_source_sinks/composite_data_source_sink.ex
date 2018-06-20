defmodule MessagingStatusService.Calls.CompositeDataSourceSink do
  @behaviour MessagingStatusService.Calls.DataSourceSinkBehaviour

  require Logger

  @data_source_sinks Application.get_env(:messaging_status_service, :calls)[:composite_data_source_sink_targets]

  def store_call_log(call_log) do
    Logger.debug("#{__MODULE__}::store_call_log call_log(#{inspect(call_log)})")

    results = @data_source_sinks |> Enum.map(fn data_source_sink ->
      data_source_sink.store_call_log(call_log)
    end)

    Logger.debug("#{__MODULE__}::store_call_log results: #{inspect(results)}")

    :ok
  end
end
