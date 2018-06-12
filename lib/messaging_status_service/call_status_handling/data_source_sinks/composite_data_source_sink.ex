defmodule MessagingStatusService.CallStatusHandling.CompositeDataSourceSink do
  @behaviour MessagingStatusService.CallStatusHandling.DataSourceSinkBehaviour

  require Logger

  def store_call_log(call_log) do
    Logger.debug("#{__MODULE__}::store_call_log call_log(#{inspect(call_log)})")
    :ok
  end
end
