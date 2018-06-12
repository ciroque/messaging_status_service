defmodule CallLogsTest do
  use MessagingStatusService.DataCase

  alias MessagingStatusService.CallLogs

  describe "CallLogs" do
    test "create CallLog record" do
      assert {:ok, record} = CallLogs.create(sample_call_log_attrs())
      assert record |> drop_distracting_fields == sample_call_log_attrs() |> drop_distracting_fields
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
end
