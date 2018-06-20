defmodule MessagingStatusService.Calls.HoneydewEctoCallCompletedWorker do
  require Logger

  alias MessagingStatusService.Calls.CallLogResolver
  alias MessagingStatusService.Calls.CallSid
  alias MessagingStatusService.Calls.CallSids

  def run(id) do
    Logger.debug("#{__MODULE__}:: run id(#{id})")
    %CallSid{call_sid: call_sid} = CallSids.get!(id)
    CallLogResolver.resolve_call_log(call_sid)
  end
end
