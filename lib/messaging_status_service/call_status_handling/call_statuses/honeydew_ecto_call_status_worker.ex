defmodule MessagingStatusService.CallStatusHandling.HoneydewEctoCallStatusWorker do
  require Logger

  alias MessagingStatusService.CallStatusHandling.CallLogResolver
  alias MessagingStatusService.CallSid
  alias MessagingStatusService.CallSids

  def run(id) do
    Logger.debug("#{__MODULE__}:: run id(#{id})")
    %CallSid{call_sid: call_sid} = CallSids.get!(id)
    CallLogResolver.resolve_call_log(call_sid)
  end
end
