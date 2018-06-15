defmodule MessagingStatusService.SmsLog do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [usec: false]

  schema "sms_logs" do
    field(:account_sid, :string)
    field(:body, :string)
    field(:date_created, :utc_datetime)
    field(:date_sent, :utc_datetime)
    field(:date_updated, :utc_datetime)
    field(:direction, :string)
    field(:error_code, :string)
    field(:error_message, :string)
    field(:from, :string)
    field(:messaging_service_sid, :string)
    field(:num_media, :string)
    field(:num_segments, :string)
    field(:price, :string)
    field(:price_unit, :string)
    field(:sid, :string)
    field(:status, :string)
    field(:to, :string)
    field(:uri, :string)

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = sms_log, attrs) do
    sms_log
    |> cast(attrs, cast_fields())
    |> validate_required(required_fields())
  end

  defp cast_fields() do
    ~w(
      account_sid
      body
      date_created
      date_sent
      date_updated
      direction
      error_code
      error_message
      from
      messaging_service_sid
      num_media
      num_segments
      price
      price_unit
      sid
      status
      to
      uri)a
  end

  defp required_fields() do
    ~w(
      account_sid
      body
      direction
      from
      to
    )a
  end
end
