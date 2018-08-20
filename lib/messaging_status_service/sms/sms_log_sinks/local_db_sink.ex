defmodule MessagingStatusService.Sms.LocalDbSink do
  @behaviour MessagingStatusService.Sms.LogSinkBehaviour

  require Logger

  def store_sms_log(sms_log) do
    Logger.debug("#{__MODULE__}::store_sms_log sms_log(#{inspect(sms_log)})")

    results = MessagingStatusService.SmsLogs.store_sms_log(sms_log)

    Logger.debug("#{__MODULE__}::store_sms_log results: #{inspect(results)}")

    :ok
  end
end
