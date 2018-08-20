defmodule MessagingStatusService.Sms.EctoBackedSmsCompletedHandler do
  @behaviour MessagingStatusServiceWeb.Sms.SmsCompletedHandlerBehaviour

  alias MessagingStatusService.Sms.SmsSids

  require Logger

  def handle_sms_completed(%{"SmsSid" => _sms_sid, "SmsStatus" => "received"} = call_info) do
    Logger.info("#{__MODULE__}::handle_sms_completed RECEIVED #{inspect(call_info)}")
    :ok
  end

  def handle_sms_completed(%{"SmsSid" => sms_sid} = call_info) do
    Logger.info("#{__MODULE__}::handle_sms_completed SmsSid(#{sms_sid}), SMS info(#{inspect(call_info)}}")
    case SmsSids.create(%{sms_sid: sms_sid}) do
      {:ok, _} -> :ok
      {:error, %Ecto.Changeset{errors: [sms_sid: {"has already been taken", []}]}} ->
        Logger.info("#{__MODULE__} handle_sms_completed duplicate SmsSid: #{sms_sid}}")
        :ok
      {:error, changeset} ->
        Logger.error("#{__MODULE__} handle_sms_completed: #{inspect(changeset)}}}")
        {:error, changeset}
    end
  end
end
