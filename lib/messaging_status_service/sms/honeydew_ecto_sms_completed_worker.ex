defmodule MessagingStatusService.Sms.HoneydewEctoSmsCompletedWorker do
  require Logger

  alias MessagingStatusService.Sms.SmsLogResolver
  alias MessagingStatusService.Sms.SmsSid
  alias MessagingStatusService.Sms.SmsSids

  def run(id) do
    Logger.debug("#{__MODULE__}:: run id(#{id})")
    %SmsSid{sms_sid: sms_sid} = SmsSids.get!(id)
    SmsLogResolver.resolve_sms_log(sms_sid)
  end
end
