defmodule MessagingStatusService.Calls.EctoBackedCallCompletedHandler do
  @behaviour MessagingStatusService.Calls.CallCompletedHandlerBehaviour

  alias MessagingStatusService.Calls.CallSids

  require Logger

  def handle_call_completed(%{"CallSid" => call_sid} = call_info) do
    Logger.debug("#{__MODULE__}::handle_call_completed CallSid(#{call_sid}), Call info(#{inspect(call_info)}}")
    CallSids.create(%{call_sid: call_sid})
  end
end
