defmodule MessagingStatusService.CallStatusHandling.TwilioCallLogSource do
  @behaviour MessagingStatusService.CallStatusHandling.CallLogSourceBehaviour

  require Logger

  def retrieve_call_log(id) do
    case HTTPoison.get(uri(id), headers(), options()) do
      {:ok, %{status_code: 200, body: body}} -> handle_success(Poison.decode!(body))
      {:ok, %{status_code: status_code, body: body}} -> handle_something_else(status_code, body)
      {:error, response} -> handle_error(response)
    end
  end

  defp handle_success(%{"status" => status} = body) do
    Logger.debug("#{__MODULE__} SUCCESS: #{status}")

    result = case status do
      "canceled" -> :completed
      "completed" -> :completed
      "busy" -> :completed
      "failed" -> :completed
      _ -> :in_progress
    end

    {:ok, result, body}
  end

  defp handle_something_else(status_code, body) do
    Logger.warn("#{__MODULE__} status_code: #{status_code} body: #{inspect(body)}")

    result = case status_code do
      404 -> :completed
      _> :in_progress
    end

    {:ok, result, body}
  end

  defp handle_error(response) do
    Logger.error("#{__MODULE__} ERROR: #{inspect(response)}")

    {:error, :completed, response}
  end

  defp headers() do
    [{"Content-Type", "application/x-www-form-urlencoded"}]
  end

  defp options() do
    [
      hackney:
        [
          basic_auth: {
            twilio_sid(),
            twilio_secret()
        }
      ]
    ]
  end

  defp uri(id) do
    twilio_base_uri = "https://api.twilio.com"
    path = [
             "2010-04-01/Accounts",
             twilio_account_sid(),
             "Calls/#{id}.json"
           ] |> Enum.join("/")

    "#{twilio_base_uri}/#{path}"
  end

  defp twilio_account_sid() do
    app_config(:TWILIO_ACCOUNT_SID)
  end

  defp twilio_sid() do
    app_config(:TWILIO_SID)
  end

  defp twilio_secret() do
    app_config(:TWILIO_SECRET)
  end

  defp app_config(key) do
    Application.get_env(:messaging_status_service, :call_status_handling)[key]
  end
end
