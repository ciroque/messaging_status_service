defmodule MessagingStatusService.Calls.DataSourceSinkBehaviour do
  @type call_log_t :: MessagingStatusService.CallLog.t()
  @type error_t :: any()

  @callback store_call_log(call_log_t) :: :ok | {:error, error_t}
end
