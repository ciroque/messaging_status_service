defmodule MessagingStatusService.SmsSid do
  use Ecto.Schema
  import Ecto.Changeset
  import Honeydew.EctoPollQueue.Schema

  @timestamps_opts [usec: false]

  schema "sms_sids" do
    field(:sms_sid, :string)
    honeydew_fields(:sms_sid_handler)
    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = sms_sid, attrs) do
    sms_sid
    |> cast(attrs, [:sms_sid])
    |> validate_required([:sms_sid])
    |> unique_constraint(:sms_sid, name: :sms_sid_must_be_unique)
  end
end
