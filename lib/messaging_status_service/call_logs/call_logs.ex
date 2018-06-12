defmodule MessagingStatusService.CallLogs do
  import Ecto.Query, warn: false

  alias MessagingStatusService.CallLog
  alias MessagingStatusService.Repo

  def create(attrs \\ %{}) do
    %CallLog{}
    |> CallLog.changeset(attrs)
    |> Repo.insert
  end
end
