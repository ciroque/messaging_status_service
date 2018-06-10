defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker do
  @moduledoc false

  @behaviour Honeydew.Worker

  require Logger

  def init(state) do
    {:ok, state}
  end

  def handle_call_status(%{"DialCallSid" => dial_call_sid} = status, state) do
    Logger.debug("#{__MODULE__}: handle_call_status status(#{inspect(status)}}), state(#{inspect(state)}) ")
    # 1. Use CallSID to look up call logs from Twilio
    Logger.debug("#{__MODULE__}: handle_call_status Looking up call log for sid '#{dial_call_sid}'...")

    # 2. If the status is complete, update the database
    Logger.debug("#{__MODULE__}: handle_call_status Here the @data_source_sink will be called if the call log shows the call is complete...")

    # 3. Else, requeue the message for later processing
    Logger.debug("#{__MODULE__}: handle_call_status Or the call status will be requeued if the call log shows the call is not yet complete...")

    :ok
  end
end
