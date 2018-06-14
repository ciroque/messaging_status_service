defmodule MessagingStatusService.Repo.Migrations.CreateCallLogsTable do
  use Ecto.Migration

  def change do
    create table(:call_logs) do
      add :account_sid, :string
      add :answered_by, :string
      add :caller_name, :string
      add :date_updated, :utc_datetime
      add :duration, :integer
      add :forwarded_from, :string
      add :from_formatted, :string
      add :parent_call_sid, :string
      add :price, :string
      add :sid, :string
      add :status, :string
      add :to, :string
      add :uri, :string
      add :annotation, :string
      add :api_version, :string
      add :date_created, :utc_datetime
      add :direction, :string
      add :end_time, :utc_datetime
      add :from, :string
      add :group_sid, :string
      add :phone_number_sid, :string
      add :price_unit, :string
      add :start_time, :utc_datetime
      add :to_formatted, :string

      timestamps()
    end
  end
end
