defmodule MessagingStatusService.SmsLogs do
  import Ecto.Query, warn: false

  alias MessagingStatusService.SmsLog
  alias MessagingStatusService.Repo

  require Logger

#  @behaviour MessagingStatusService.Calls.DataSourceSinkBehaviour

  def store_sms_log(sms_log) do
    {:ok, date_created} = to_rfc1123_date_time(sms_log["date_created"])
    {:ok, date_updated} = to_rfc1123_date_time(sms_log["date_updated"])
    {:ok, start_time} = to_rfc1123_date_time(sms_log["start_time"])
    {:ok, end_time} = to_rfc1123_date_time(sms_log["end_time"])

    sms_log = sms_log
    |> Map.put("date_created", date_created)
    |> Map.put("date_updated", date_updated)
    |> Map.put("start_time", start_time)
    |> Map.put("end_time", end_time)

    case create(sms_log) do
      {:ok, _} -> :ok
      {:error, error} ->
        Logger.error("#{__MODULE__}::store_call_log: #{inspect(error)}")
        :error
    end
  end

  def create(attrs \\ %{}) do
    %SmsLog{}
    |> SmsLog.changeset(attrs)
    |> Repo.insert
  end

  defp to_rfc1123_date_time(date_time) do
    date_time |> Timex.parse("{RFC1123}")
  end
end
