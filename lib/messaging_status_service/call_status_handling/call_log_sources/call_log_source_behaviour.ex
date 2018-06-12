defmodule MessagingStatusService.CallStatusHandling.CallLogSourceBehaviour do
  @type id_t :: String.t()
  @type call_log_status_t :: :completed | :in_progress
  @type call_log_t :: map()
  @type error_t :: any()

  @callback retrieve_call_log(id_t) :: {:ok, call_log_status_t, call_log_t} | {:error, error_t}
end
