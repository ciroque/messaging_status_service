defmodule MessagingStatusService.Repo.Migrations.CreateUniqueIndexOnSmsSid do
  use Ecto.Migration

  def change do
    create unique_index(:sms_sids, :sms_sid, name: :sms_sid_must_be_unique)
  end
end
