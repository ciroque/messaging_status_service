defmodule MessagingStatusService.CallLog do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [usec: false]

  schema "call_logs" do
    field :account_sid, :string
    field :annotation, :string
    field :answered_by, :string
    field :api_version, :string
    field :caller_name, :string
    field :date_created, :utc_datetime
    field :date_updated, :utc_datetime
    field :direction, :string
    field :duration, :integer
    field :end_time, :utc_datetime
    field :forwarded_from, :string
    field :from, :string
    field :from_formatted, :string
    field :group_sid, :string
    field :parent_call_sid, :string
    field :phone_number_sid, :string
    field :price, :string
    field :price_unit, :string
    field :sid, :string
    field :start_time, :utc_datetime
    field :status, :string
    field :to, :string
    field :to_formatted, :string
    field :uri, :string

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  @doc false
  def changeset(%__MODULE__{} = call_log, attrs) do
    call_log
    |> cast(attrs, [:account_sid, :answered_by, :caller_name, :date_updated, :duration, :forwarded_from, :from_formatted, :parent_call_sid, :price, :sid, :status, :to, :uri, :annotation, :api_version, :date_created, :direction, :end_time, :from, :group_sid, :phone_number_sid, :price_unit, :start_time, :to_formatted])
    |> unique_constraint(:to, name: :unique_call_log_entry)
    |> validate_required([:account_sid, :date_updated, :duration, :forwarded_from, :from_formatted, :sid, :status, :to, :uri, :api_version, :date_created, :direction, :end_time, :from, :phone_number_sid, :price_unit, :start_time, :to_formatted])
  end
end
