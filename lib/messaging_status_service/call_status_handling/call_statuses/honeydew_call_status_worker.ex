defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker do
  @behaviour Honeydew.Worker

  require Logger

  alias MessagingStatusService.CallStatusHandling.CallLogResolver

  def init(state) do
    {:ok, state}
  end

  def handle_call_status(%{"CallSid" => call_sid} = call_status, state) do
    Logger.debug("#{__MODULE__}: handle_call_status status(#{inspect(call_status)}}), state(#{inspect(state)}) ")

    CallLogResolver.resolve_call_log(call_sid)

    :ok
  end
end
