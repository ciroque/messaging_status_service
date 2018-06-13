defmodule MessagingStatusService.CallStatusHandling.CallLogResolver do
  require Logger

  @requeue_delay Application.get_env(:messaging_status_service, :call_status_handling)[:requeue_delay]
  @call_log_source Application.get_env(:messaging_status_service, :call_status_handling)[:call_log_source]
  @call_status_handler Application.get_env(:messaging_status_service, :call_status_handling)[:call_status_handler]
  @data_source_sink Application.get_env(:messaging_status_service, :call_status_handling)[:data_source_sink]
  @error_sink Application.get_env(:messaging_status_service, :call_status_handling)[:error_sink]

  @spec resolve_call_log(String.t())
    :: {:ok, :completed, map()}
    | {:ok, :in_progres, map()}
    | {:error, any()}
  def resolve_call_log(call_sid) do
    case @call_log_source.retrieve_call_log(call_sid) do
      {:ok, :completed, call_log} -> push_to_data_source(call_log)
      {:ok, :in_progress, _call_log} -> requeue(call_sid)
      {:error, reason} -> handle_error(reason, call_sid)
    end
  end

  defp handle_error(reason, call_sid) do
    @error_sink.error("#{__MODULE__} ERROR -> #{inspect(reason)}, CALL_STATUS -> #{inspect(call_sid)}")
  end

  defp push_to_data_source(call_log) do
    Logger.debug("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
    @data_source_sink.store_call_log(call_log)
  end

  defp requeue(call_sid) do
    Logger.debug("#{__MODULE__}: handle_call_status Call is in_progress: #{inspect(call_sid)}}")
    :timer.sleep(@requeue_delay)
    @call_status_handler.handle_call_status(%{"CallSid" => call_sid})
  end
end
