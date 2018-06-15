defmodule MessagingStatusServiceWeb.Sms.SmsCompletedHandlerBehaviour do
  @type sms_info_t :: map()
  @type error_t :: any()

  @callback handle_sms_completed(sms_info_t) :: :ok | {:error, error_t}
end
