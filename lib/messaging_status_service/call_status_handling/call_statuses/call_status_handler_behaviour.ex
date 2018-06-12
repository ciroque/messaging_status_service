defmodule MessagingStatusService.CallStatusHandling.CallStatusHandlerBehaviour do
  @type call_status_t :: map()
  @type error_t :: any()

  @callback handle_call_status(call_status_t) :: {:ok} | {:error, error_t}
end
