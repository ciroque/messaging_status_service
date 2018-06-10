defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusHandler do
  @behaviour MessagingStatusService.CallStatusHandling.CallStatusHandlerBehaviour

  def handle_call_status(call_status) do
    {:handle_call_status, [call_status]}
    |> Honeydew.async(:call_status_handling)
#    |> Honeydew.yield
  end
end
