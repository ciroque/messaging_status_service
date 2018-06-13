defmodule MessagingStatusService.CallSid do
  use Ecto.Schema
  import Ecto.Changeset
  import Honeydew.EctoPollQueue.Schema

  @timestamps_opts [usec: false]

  schema "call_sids" do
    field(:call_sid, :string)
    honeydew_fields(:call_sid_handler)
    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = call_sid, attrs) do
    call_sid
    |> cast(attrs, [:call_sid])
    |> validate_required([:call_sid])
  end
end
