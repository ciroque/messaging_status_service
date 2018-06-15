defmodule MessagingStatusService.Calls.HoneydewCallCompletedHandler do
  @behaviour MessagingStatusService.Calls.CallCompletedHandlerBehaviour

  def handle_call_completed(call_info) do
    {:handle_call_completed, [call_info]}
    |> Honeydew.async(:calls)
  end
end
