defmodule MessagingStatusService.Sms.SmsLogResolver do
  require Logger

  @data_source_sink Application.get_env(:messaging_status_service, :calls)[:sms_log_sink]
  @error_sink Application.get_env(:messaging_status_service, :calls)[:error_sink]
  @log_source Application.get_env(:messaging_status_service, :calls)[:log_source]

  @spec resolve_sms_log(String.t())
        :: {:ok, :completed, map()}
           | {:ok, :in_progres, map()}
           | {:error, any()}
  def resolve_sms_log(sms_sid) do
    case @log_source.retrieve_sms_log(sms_sid) do
      {:ok, :completed, sms_log} -> push_to_data_source(sms_log)
      {:ok, :in_progress, _sms_log} -> requeue(sms_sid)
      {:error, reason} -> handle_error(reason, sms_sid)
    end
  end

  defp handle_error(reason, sms_sid) do
    @error_sink.error("#{__MODULE__} ERROR -> #{inspect(reason)}, SMS_SID -> #{inspect(sms_sid)}")
  end

  defp push_to_data_source(call_log) do
    Logger.info("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
    @data_source_sink.store_sms_log(call_log)
  end

  defp requeue(sms_sid) do
    Logger.info("#{__MODULE__}: requeue is in_progress: #{inspect(sms_sid)}}")
#    :timer.sleep(@requeue_delay)
#    @call_completed_handler.handle_call_completed(%{"CallSid" => call_sid})
  end
end
