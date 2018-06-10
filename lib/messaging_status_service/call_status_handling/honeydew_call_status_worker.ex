defmodule MessagingStatusService.CallStatusHandling.HoneydewCallStatusWorker do
  @moduledoc false

  @behaviour Honeydew.Worker

  require Logger

  @call_log_source MessagingStatusService.CallStatusHandling.TwilioCallLogSource

  def init(state) do
    {:ok, state}
  end

  def handle_call_status(%{"DialCallSid" => dial_call_sid} = status, state) do
    Logger.debug("#{__MODULE__}: handle_call_status status(#{inspect(status)}}), state(#{inspect(state)}) ")

    Logger.debug("#{__MODULE__}: handle_call_status Looking up call log for sid '#{dial_call_sid}'...")
    case @call_log_source.retrieve_call_log(dial_call_sid) do
      {:ok, :completed, call_log} -> push_to_data_source(call_log)
      {:ok, :in_progress, _call_log} -> requeue(status)
    end

    :ok
  end

  defp push_to_data_source(call_log) do
    Logger.debug("#{__MODULE__}: push_to_data_source Call is complete: #{inspect(call_log)}}")
  end

  defp requeue(status) do
    Logger.debug("#{__MODULE__}: handle_call_status Call is in_progress: #{inspect(status)}}")
  end
end
