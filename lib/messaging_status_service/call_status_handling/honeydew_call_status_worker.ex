defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker do
  @moduledoc false

  @behaviour Honeydew.Worker

  require Logger

  @requeue_delay Application.get_env(:messaging_status_service, :call_status_handling)[:requeue_delay]
  @call_log_source Application.get_env(:messaging_status_service, :call_status_handling)[:call_log_source]
  @call_status_handler Application.get_env(:messaging_status_service, :call_status_handling)[:call_status_handler]
  @data_source_sink Application.get_env(:messaging_status_service, :call_status_handling)[:data_source_sink]
  @error_sink Application.get_env(:messaging_status_service, :call_status_handling)[:error_sink]

  def init(state) do
    {:ok, state}
  end

  def handle_call_status(%{"CallSid" => call_sid} = call_status, state) do
    Logger.debug("#{__MODULE__}: handle_call_status status(#{inspect(call_status)}}), state(#{inspect(state)}) ")

    case @call_log_source.retrieve_call_log(call_sid) do
      {:ok, :completed, call_log} -> push_to_data_source(call_log)
      {:ok, :in_progress, _call_log} -> requeue(call_status)
      {:error, reason} -> handle_error(reason, call_status)
    end

    :ok
  end

  defp handle_error(reason, call_status) do
    @error_sink.error("#{__MODULE__} ERROR -> #{inspect(reason)}, CALL_STATUS -> #{inspect(call_status)}")
  end

  defp push_to_data_source(call_log) do
    Logger.debug("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
    @data_source_sink.store_call_log(call_log)
  end

  defp requeue(call_status) do
    Logger.debug("#{__MODULE__}: handle_call_status Call is in_progress: #{inspect(call_status)}}")
    :timer.sleep(@requeue_delay)
    @call_status_handler.handle_call_status(call_status)
  end
end
