defmodule MessagingStatusService.Repo.Migrations.CreateSmsLogsTable do
  use Ecto.Migration

  def change do
    create table(:sms_logs) do
      add(:account_sid, :string)
      add(:body, :string)
      add(:date_created, :utc_datetime)
      add(:date_sent, :utc_datetime)
      add(:date_updated, :utc_datetime)
      add(:direction, :string)
      add(:error_code, :string)
      add(:error_message, :string)
      add(:from, :string)
      add(:messaging_service_sid, :string)
      add(:num_media, :string)
      add(:num_segments, :string)
      add(:price, :string)
      add(:price_unit, :string)
      add(:sid, :string)
      add(:status, :string)
      add(:to, :string)
      add(:uri, :string)

      timestamps()
    end
  end
end
