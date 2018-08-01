defmodule MessagingStatusService.LogSourceBehaviour do
  @type id_t :: String.t()
  @type log_entry_status_t :: :completed | :in_progress
  @type log_entry_t :: map()
  @type error_t :: any()

  @callback retrieve_call_log(id_t) :: {:ok, log_entry_status_t, log_entry_t} | {:error, error_t}
  @callback retrieve_sms_log(id_t) :: {:ok, log_entry_status_t, log_entry_t} | {:error, error_t}
end
