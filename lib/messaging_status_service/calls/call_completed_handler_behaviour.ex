defmodule MessagingStatusService.Calls.CallCompletedHandlerBehaviour do
  @type call_info_t :: map()
  @type error_t :: any()

  @callback handle_call_completed(call_info_t) :: :ok | {:error, error_t}
end
