defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker do
  @moduledoc false

  @behaviour Honeydew.Worker

  require Logger

  @data_source_sink Application.get_env(:messaging_status_service, :call_status_handling)[:data_source_sink]
  @call_log_source Application.get_env(:messaging_status_service, :call_status_handling)[:call_log_source]
  @call_status_handler Application.get_env(:messaging_status_service, :call_status_handling)[:call_status_handler]

  def init(state) do
    {:ok, state}
  end

  def handle_call_status(%{"CallSid" => call_sid} = status, state) do
    Logger.debug("#{__MODULE__}: handle_call_status status(#{inspect(status)}}), state(#{inspect(state)}) ")

    Logger.debug("#{__MODULE__}: handle_call_status Looking up call log for sid '#{call_sid}'...")
    case @call_log_source.retrieve_call_log(call_sid) do
      {:ok, :completed, call_log} -> push_to_data_source(call_log)
      {:ok, :in_progress, _call_log} -> requeue(status)
    end

    :ok
  end

  defp push_to_data_source(call_log) do
    Logger.debug("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
    @data_source_sink.store_call_log(call_log)
  end

  defp requeue(status) do
    Logger.debug("#{__MODULE__}: handle_call_status Call is in_progress: #{inspect(status)}}")
    :timer.sleep(5_000)
    @call_status_handler.handle_call_status(status)
  end
end
