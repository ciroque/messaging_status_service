defmodule MessagingStatusService.Repo.Migrations.CreateCallSidQueueTable do
  use Ecto.Migration
  import Honeydew.EctoPollQueue.Migration

  def change do
    create table(:call_sids) do
      add(:call_sid, :string)
      honeydew_fields(:call_sid_handler)
      timestamps()
    end

    honeydew_indexes(:call_sids, :call_sid_handler)
  end
end
