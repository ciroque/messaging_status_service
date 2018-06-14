defmodule MessagingStatusService.Repo.Migrations.CreateSmsStatusTable do
  use Ecto.Migration

  def change do
    create table(:sms_statuses) do
      add(:to, :string)
      add(:from, :string)
      add(:message_sid, :string)
      add(:message_status, :string)
      add(:sms_sid, :string)
      add(:sms_status, :string)
      add(:api_version, :string)

      timestamps()
    end
  end
end
