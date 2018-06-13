defmodule MessagingStatusService.CallStatusHandling.EctoBackedCallStatusHandler do
  @behaviour MessagingStatusService.CallStatusHandling.CallStatusHandlerBehaviour

  alias MessagingStatusService.CallSids

  require Logger

  def handle_call_status(%{"CallSid" => call_sid} = call_status) do
    Logger.debug("#{__MODULE__}::handle_call_status CallSid(#{call_sid}), CallStatus(#{inspect(call_status)}}")
    CallSids.create(%{call_sid: call_sid})
  end
end
