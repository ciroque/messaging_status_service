defmodule MessagingStatusService.Repo.Migrations.CreateSmsSidsTable do
  use Ecto.Migration
  import Honeydew.EctoPollQueue.Migration

  def change do
    create table(:sms_sids) do
      add(:sms_sid, :string)
      honeydew_fields(:sms_sid_handler)
      timestamps()
    end

    honeydew_indexes(:sms_sids, :sms_sid_handler)
  end
end
