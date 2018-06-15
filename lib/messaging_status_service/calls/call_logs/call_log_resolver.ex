defmodule MessagingStatusService.Calls.CallLogResolver do
  require Logger

  @requeue_delay Application.get_env(:messaging_status_service, :calls)[:requeue_delay]
  @call_log_source Application.get_env(:messaging_status_service, :calls)[:call_log_source]
  @call_completed_handler Application.get_env(:messaging_status_service, :calls)[:call_completed_handler]
  @data_source_sink Application.get_env(:messaging_status_service, :calls)[:data_source_sink]
  @error_sink Application.get_env(:messaging_status_service, :calls)[:error_sink]

  @spec resolve_call_log(String.t())
    :: {:ok, :completed, map()}
    | {:ok, :in_progres, map()}
    | {:error, any()}
  def resolve_call_log(call_sid) do
    case @call_log_source.retrieve_log(call_sid) do
      {:ok, :completed, call_log} -> push_to_data_source(call_log)
      {:ok, :in_progress, _call_log} -> requeue(call_sid)
      {:error, reason} -> handle_error(reason, call_sid)
    end
  end

  defp handle_error(reason, call_sid) do
    @error_sink.error("#{__MODULE__} ERROR -> #{inspect(reason)}, CALL_SID -> #{inspect(call_sid)}")
  end

  defp push_to_data_source(call_log) do
    Logger.debug("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
    @data_source_sink.store_call_log(call_log)
  end

  defp requeue(call_sid) do
    Logger.debug("#{__MODULE__}: requeue Call is in_progress: #{inspect(call_sid)}}")
    :timer.sleep(@requeue_delay)
    @call_completed_handler.handle_call_completed(%{"CallSid" => call_sid})
  end
end
