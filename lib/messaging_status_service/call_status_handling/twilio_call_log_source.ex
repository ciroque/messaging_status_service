defmodule MessagingStatusService.CallStatusHandling.TwilioCallLogSource do
  @behaviour MessagingStatusService.CallStatusHandling.CallLogSourceBehaviour

  require Logger

  def retrieve_call_log(id) do
    Logger.debug("#{__MODULE__}::retrieve_call_log id(#{id})")
    {:ok, :in_progress, %{"CallLogSid" => id}}
  end
end
