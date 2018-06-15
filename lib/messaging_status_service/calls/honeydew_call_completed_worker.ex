defmodule MessagingStatusService.Calls.HoneydewCallCompletedWorker do
  @behaviour Honeydew.Worker

  require Logger

  alias MessagingStatusService.Calls.CallLogResolver

  def init(state) do
    {:ok, state}
  end

  def handle_call_completed(%{"CallSid" => call_sid} = call_info, state) do
    Logger.debug("#{__MODULE__}: handle_call_completed status(#{inspect(call_info)}}), state(#{inspect(state)}) ")

    CallLogResolver.resolve_call_log(call_sid)

    :ok
  end
end
