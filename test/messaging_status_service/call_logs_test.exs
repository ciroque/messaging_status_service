defmodule CallLogsTest do
  use MessagingStatusService.DataCase

  alias MessagingStatusService.Calls.CallLogs

  describe "CallLogs" do
    test "create CallLog record" do
      assert {:ok, record} = CallLogs.create(sample_call_log_attrs())
      assert record |> drop_distracting_fields == sample_call_log_attrs() |> drop_distracting_fields
    end

    test "actual record from Twilio" do
      assert :ok = CallLogs.store_call_log(actual())
    end
  end

  defp drop_distracting_fields(m) do
    m |> Map.drop([:__meta__, :__struct__, :inserted_at, :date_created, :date_updated, :id, :end_time, :start_time, :updated_at])
  end

  defp sample_call_log_attrs() do
    %{
      account_sid: "account_sid",
      annotation: nil,
      answered_by: nil,
      api_version: "api_version",
      caller_name: nil,
      date_created: DateTime.utc_now(),
      date_updated: DateTime.utc_now(),
      direction: "direction",
      duration: 17,
      end_time: DateTime.utc_now(),
      forwarded_from: "forwarded_from",
      from: "from",
      from_formatted: "from_formatterd",
      group_sid: nil,
      parent_call_sid: nil,
      phone_number_sid: "phone_number_sid",
      price: "price ",
      price_unit: "price_unit",
      sid: "sid",
      start_time: DateTime.utc_now(),
      status: "status",
      to: "to",
      to_formatted: "to_formatted",
      uri: "uri"
    }
  end

  defp actual() do
    %{
      "account_sid" => "AC69adbf55f687c6005059f14599cda396",
      "annotation" => nil,
      "answered_by" => nil,
      "api_version" => "2010-04-01",
      "caller_name" => nil,
      "date_created" => "Tue, 12 Jun 2018 20:27:48 +0000",
      "date_updated" => "Tue, 12 Jun 2018 20:28:09 +0000",
      "direction" => "inbound",
      "duration" => "20",
      "end_time" => "Tue, 12 Jun 2018 20:28:09 +0000",
      "forwarded_from" => "+12064880530",
      "from" => "+12068185722",
      "from_formatted" => "(206) 818-5722",
      "group_sid" => nil,
      "parent_call_sid" => nil,
      "phone_number_sid" => "PN5d27aef58657f1b791edddb360ada735",
      "price" => nil,
      "price_unit" => "USD",
      "sid" => "CA4a99bab47eecb3516384d041c58289f4",
      "start_time" => "Tue, 12 Jun 2018 20:27:49 +0000",
      "status" => "completed",
      "subresource_uris" => %{
        "notifications" => "/2010-04-01/Accounts/AC69adbf55f687c6005059f14599cda396/Calls/CA4a99bab47eecb3516384d041c58289f4/Notifications.json",
        "recordings" => "/2010-04-01/Accounts/AC69adbf55f687c6005059f14599cda396/Calls/CA4a99bab47eecb3516384d041c58289f4/Recordings.json"
      },
      "to" => "+12064880530",
      "to_formatted" => "(206) 488-0530",
      "uri" => "/2010-04-01/Accounts/AC69adbf55f687c6005059f14599cda396/Calls/CA4a99bab47eecb3516384d041c58289f4.json"}
  end
end
