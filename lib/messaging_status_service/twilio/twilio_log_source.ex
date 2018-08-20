defmodule MessagingStatusService.TwilioLogSource do
  @behaviour MessagingStatusService.LogSourceBehaviour

  require Logger

  @http_client Application.get_env(:messaging_status_service, :calls)[:http_client]

  def retrieve_sms_log(id) do
    retrieve_log(sms_uri(id))
  end

  def retrieve_call_log(id) do
    retrieve_log(call_uri(id))
  end

  def retrieve_log(uri) do
    Logger.info("#{__MODULE__}::retrieve_log uri(#{uri})")
    response = @http_client.get(uri, headers(), options())
    case response do
      {:ok, %{status_code: 200, body: body}} -> handle_success(Poison.decode!(body))
      {:ok, %{status_code: 404, body: body}} -> handle_not_found(Poison.decode!(body))
      {:ok, %{status_code: status_code, body: body}} -> handle_unexpected_status_code(status_code, Poison.decode!(body))
      {:error, response} -> handle_error(response)
    end
  end

  defp handle_not_found(body) do
    Logger.error("#{__MODULE__} NOT FOUND #{inspect(body)}")
    {:error, :not_found}
  end

  defp handle_success(%{"status" => status} = body) do
    Logger.debug("#{__MODULE__} SUCCESS: #{status}")

    result = case status do
      "canceled" -> :completed
      "completed" -> :completed
      "busy" -> :completed
      "failed" -> :completed
      "delivered" -> :completed
      "received" -> :completed
      "undelivered" -> :completed
      "queued" -> :in_progress
      "sent" -> :in_progress
      _ -> :in_progress
    end

    {:ok, result, body}
  end

  defp handle_unexpected_status_code(status_code, body) do
    Logger.error("#{__MODULE__} status_code: #{status_code} body: #{inspect(body)}")
    {:error, body}
  end

  defp handle_error(response) do
    Logger.error("#{__MODULE__} ERROR: #{inspect(response)}")
    {:error, response}
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

  defp call_uri(id) do
    twilio_base_uri = "https://api.twilio.com"
    path = [
             "2010-04-01/Accounts",
             twilio_account_sid(),
             "Calls/#{id}.json"
           ] |> Enum.join("/")

    "#{twilio_base_uri}/#{path}"
  end

  defp sms_uri(id) do
    twilio_base_uri = "https://api.twilio.com"
    path = [
             "2010-04-01/Accounts",
             twilio_account_sid(),
             "Messages/#{id}.json"
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
    Application.get_env(:messaging_status_service, :calls)[key]
  end
end
