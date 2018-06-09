defmodule MessagingStatusService.Repo.Migrations.CreatePhoneStatusTable do
  use Ecto.Migration

  def change do
    create table(:call_statuses) do
      add(:to, :string)
      add(:from, :string)
      add(:date, :utc_datetime)
      add(:started, :utc_datetime)
      add(:ended, :utc_datetime)
      add(:duration, :integer)
      add(:from_city, :string)
      add(:from_state, :string)
      add(:from_zip, :string)
      add(:from_country, :string)
      add(:api_version, :string)
      add(:call_sid, :string)
      add(:call_status, :string)
      add(:called, :string)
      add(:called_city, :string)
      add(:called_state, :string)
      add(:called_zip, :string)
      add(:called_country, :string)
      add(:caller, :string)
      add(:caller_city, :string)
      add(:caller_state, :string)
      add(:caller_zip, :string)
      add(:caller_country, :string)
      add(:dial_call_duration, :integer)
      add(:dial_call_status, :string)
      add(:direction, :string)
    end
  end
end
