defmodule MessagingStatusService.Sms.HoneydewEctoSmsCompletedWorker do
  require Logger

#  alias MessagingStatusService.Calls.CallLogResolver
  alias MessagingStatusService.Sms.SmsSid
  alias MessagingStatusService.Sms.SmsSids

  def run(id) do
    Logger.debug("#{__MODULE__}:: run id(#{id})")
    %SmsSid{sms_sid: sms_sid} = SmsSids.get!(id)
#    CallLogResolver.resolve_call_log(call_sid)
  end
end
