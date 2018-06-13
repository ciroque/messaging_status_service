defmodule MessagingStatusService.CallSids do
  import Ecto.Query, warn: false

  alias MessagingStatusService.CallSid
  alias MessagingStatusService.Repo

  def create(attrs \\ %{}) do
    %CallSid{}
    |> CallSid.changeset(attrs)
    |> Repo.insert
  end

  def get!(id) do
    Repo.get!(CallSid, id)
  end
end
