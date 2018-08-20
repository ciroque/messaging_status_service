defmodule MessagingStatusService.Sms.LogSinkBehaviour do
  @type sms_log_t :: MessagingStatusService.SmsLog.t()
  @type error_t :: any()

  @callback store_sms_log(sms_log_t) :: :ok | {:error, error_t}
end
